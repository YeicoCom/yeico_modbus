ExUnit.start()

defmodule Shared do
  @moduledoc false
  alias Modbus.Model

  def start_link(model) do
    Agent.start_link(fn -> model end)
  end

  def stop(pid, reason) do
    Agent.stop(pid, reason)
  end

  def state(pid) do
    Agent.get(pid, fn model -> model end)
  end

  def apply(pid, cmd) do
    Agent.get_and_update(pid, fn model ->
      try do
        case Model.apply(model, cmd) do
          {:ok, nmodel, values} ->
            {{:ok, values}, nmodel}

          {:ok, nmodel} ->
            {:ok, nmodel}

          {:error, nmodel} ->
            {{:error, {:invalid, cmd}}, nmodel}
        end
      rescue
        _ -> {{:error, {:invalid, cmd}}, model}
      end
    end)
  end
end

defmodule Slave do
  @moduledoc false
  use GenServer
  alias Modbus.Transport
  alias Modbus.Protocol

  def start_link(opts) do
    ip = Keyword.get(opts, :ip, "127.0.0.1")
    ip = if is_binary(ip), do: parse(ip), else: ip
    port = Keyword.get(opts, :port, 0)
    model = Keyword.fetch!(opts, :model)
    trans = Modbus.Tcp.Transport
    proto = Keyword.get(opts, :proto, Modbus.Tcp.Protocol)
    init = %{trans: trans, proto: proto, model: model, port: port, ip: ip}
    GenServer.start_link(__MODULE__, init)
  end

  def init(init) do
    {:ok, shared} = Shared.start_link(init.model)
    opts = [:binary, ip: init.ip, packet: :raw, active: false]

    case :gen_tcp.listen(init.port, opts) do
      {:ok, listener} ->
        {:ok, {ip, port}} = :inet.sockname(listener)

        init = Map.put(init, :ip, ip)
        init = Map.put(init, :port, port)
        init = Map.put(init, :shared, shared)
        init = Map.put(init, :listener, listener)

        spawn_link(fn -> accept(init) end)

        {:ok, init}

      {:error, reason} ->
        {:stop, reason}
    end
  end

  def terminate(reason, %{shared: shared}) do
    Shared.stop(shared, reason)
  end

  def stop(pid) do
    # listener automatic close should
    # close the accepting process which
    # should close all client sockets
    GenServer.stop(pid)
  end

  def port(pid) do
    GenServer.call(pid, :port)
  end

  def handle_call(:port, _from, state) do
    {:reply, state.port, state}
  end

  defp accept(%{shared: shared, proto: proto} = state) do
    case :gen_tcp.accept(state.listener) do
      {:ok, socket} ->
        trans = {state.trans, socket}
        spawn(fn -> client(shared, trans, proto) end)
        accept(state)

      {:error, reason} ->
        Process.exit(self(), reason)
    end
  end

  defp client(shared, trans, proto) do
    case Transport.readp(trans) do
      {:ok, data} ->
        {cmd, tid} = Protocol.parse_req(proto, data)

        case Shared.apply(shared, cmd) do
          :ok ->
            resp = Protocol.pack_res(proto, cmd, nil, tid)
            Transport.write(trans, resp)

          {:ok, values} ->
            resp = Protocol.pack_res(proto, cmd, values, tid)
            Transport.write(trans, resp)

          _ ->
            :ignore
        end

        client(shared, trans, proto)

      {:error, reason} ->
        Process.exit(self(), reason)
    end
  end

  defp parse(ip) do
    :inet.parse_address(~c"#{ip}") |> elem(1)
  end
end

defmodule Modbus.TestHelper do
  use ExUnit.Case
  alias Modbus.Request
  alias Modbus.Response
  alias Modbus.Model
  alias Modbus.Rtu
  alias Modbus.Tcp

  def pp1(cmd, req, res, val, model) do
    assert req == Request.pack(cmd)
    assert cmd == Request.parse(req)
    assert {:ok, model, val} == Model.apply(model, cmd)
    assert res == Response.pack(cmd, val)
    assert val == Response.parse(cmd, res)
    # length prediction
    assert byte_size(res) == Response.length(cmd)
    assert byte_size(req) == Request.length(cmd)
    # rtu
    rtu_req = Rtu.Protocol.pack_req(cmd)
    assert {cmd, nil} == Rtu.Protocol.parse_req(rtu_req)
    rtu_res = Rtu.Protocol.pack_res(cmd, val)
    assert val == Rtu.Protocol.parse_res(cmd, rtu_res)
    assert byte_size(rtu_res) == Rtu.Protocol.res_len(cmd)
    # tcp
    tcp_req = Tcp.Protocol.pack_req(cmd, 1)
    assert {cmd, 1} == Tcp.Protocol.parse_req(tcp_req)
    tcp_res = Tcp.Protocol.pack_res(cmd, val, 1)
    assert val == Tcp.Protocol.parse_res(cmd, tcp_res, 1)
    assert byte_size(tcp_res) == Tcp.Protocol.res_len(cmd)
    # conn
    {:ok, slave_pid} = Slave.start_link(model: model)
    port = Slave.port(slave_pid)
    {:ok, conn_state} = Modbus.open(port: port, ip: "127.0.0.1")

    for _ <- 0..10 do
      {:ok, _, val2} = Modbus.exec(conn_state, cmd)
      assert val == val2
    end
  end

  def pp2(cmd, req, res, model0, model1) do
    assert req == Request.pack(cmd)
    assert cmd == Request.parse(req)
    assert {:ok, model1} == Model.apply(model0, cmd)
    assert res == Response.pack(cmd, nil)
    assert nil == Response.parse(cmd, res)
    # length prediction
    assert byte_size(res) == Response.length(cmd)
    # rtu
    rtu_req = Rtu.Protocol.pack_req(cmd)
    assert {cmd, nil} == Rtu.Protocol.parse_req(rtu_req)
    rtu_res = Rtu.Protocol.pack_res(cmd, nil)
    assert nil == Rtu.Protocol.parse_res(cmd, rtu_res)
    assert byte_size(rtu_res) == Rtu.Protocol.res_len(cmd)
    # tcp
    tcp_req = Tcp.Protocol.pack_req(cmd, 1)
    assert {cmd, 1} == Tcp.Protocol.parse_req(tcp_req)
    tcp_res = Tcp.Protocol.pack_res(cmd, nil, 1)
    assert nil == Tcp.Protocol.parse_res(cmd, tcp_res, 1)
    assert byte_size(tcp_res) == Tcp.Protocol.res_len(cmd)
    # conn
    {:ok, slave_pid} = Slave.start_link(model: model0)
    port = Slave.port(slave_pid)
    {:ok, conn_state} = Modbus.open(port: port, ip: "127.0.0.1")

    for _ <- 0..10 do
      {:ok, _} = Modbus.exec(conn_state, cmd)
    end
  end
end
