ExUnit.start()

defmodule Modbus do
  def get(key) do
    if !Process.get(key) do
      {_, bindings} = Code.eval_file("lib/modbus.ex")
      Enum.each(bindings, fn {k, v} -> Process.put(k, v) end)
    end

    Process.get(key)
  end

  def crc(arg), do: get(:crc).(arg)
  def master(arg), do: get(:master).(arg)
  def float(arg), do: get(:float).(arg)
  def request(arg), do: get(:request).(arg)
  def response(arg), do: get(:response).(arg)
  def model(arg), do: get(:model).(arg)
  def tcp_trans(arg), do: get(:tcp_trans).(arg)
  def rtu_proto(arg), do: get(:rtu_proto).(arg)
  def tcp_proto(arg), do: get(:tcp_proto).(arg)
  def tcp_trans(), do: get(:tcp_trans)
  def tcp_proto(), do: get(:tcp_proto)

  def utils(arg) do
    utils = get(:utils)
    utils.(Tuple.insert_at(arg, 0, utils))
  end

  def rtu_wrap(arg) do
    wrapper = get(:rtu_proto_p)
    wrapper.({:wrap, arg})
  end

  def rtu_unwrap(arg) do
    wrapper = get(:rtu_proto_p)
    wrapper.({:unwrap, arg})
  end

  def tcp_wrap(arg0, arg1) do
    wrapper = get(:tcp_proto_p)
    wrapper.({:wrap, arg0, arg1})
  end

  def tcp_unwrap(arg) do
    wrapper = get(:tcp_proto_p)
    wrapper.({:unwrap, arg})
  end
end

defmodule Shared do
  @moduledoc false
  import Modbus

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
        case Modbus.model({:apply, model, cmd}) do
          {:ok, nmodel, values} ->
            {{:ok, values}, nmodel}

          {:ok, nmodel} ->
            {:ok, nmodel}

          {:error, nmodel} ->
            {{:error, invalid: cmd}, nmodel}
        end
      rescue
        ex -> {{:error, rescue: ex, stack: __STACKTRACE__, invalid: cmd}, model}
      end
    end)
  end
end

defmodule Slave do
  @moduledoc false
  use GenServer
  import Modbus

  def start_link(opts) do
    ip = Keyword.get(opts, :ip, "127.0.0.1")
    ip = if is_binary(ip), do: parse(ip), else: ip
    port = Keyword.get(opts, :port, 0)
    model = Keyword.fetch!(opts, :model)
    proto = Keyword.get(opts, :proto, tcp_proto())
    init = %{proto: proto, model: model, port: port, ip: ip}
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
      {:ok, tstate} ->
        spawn(fn -> client(shared, tstate, proto) end)
        accept(state)

      {:error, reason} ->
        Process.exit(self(), reason)
    end
  end

  defp client(shared, tstate, proto) do
    case tcp_trans({:readp, tstate}) do
      {:ok, data} ->
        {cmd, tid} = proto.({:parse_req, data})

        case Shared.apply(shared, cmd) do
          :ok ->
            resp = proto.({:pack_res, cmd, nil, tid})
            tcp_trans({:write, tstate, resp})

          {:ok, values} ->
            resp = proto.({:pack_res, cmd, values, tid})
            tcp_trans({:write, tstate, resp})

          unexpected ->
            IO.inspect(unexpected: unexpected)
        end

        client(shared, tstate, proto)

      {:error, reason} ->
        Process.exit(self(), reason)
    end
  end

  defp parse(ip) do
    :inet.parse_address(~c"#{ip}") |> elem(1)
  end
end

defmodule TestHelper do
  use ExUnit.Case
  import Modbus

  def pp1(cmd, req, res, val, model) do
    assert req == request({:pack, cmd})
    assert cmd == request({:parse, req})
    assert {:ok, model, val} == model({:apply, model, cmd})
    assert res == response({:pack, cmd, val})
    assert val == response({:parse, cmd, res})
    # length prediction
    assert byte_size(res) == response({:length, cmd})
    assert byte_size(req) == request({:length, cmd})
    # rtu
    rtu_req = rtu_proto({:pack_req, cmd, nil})
    assert {cmd, nil} == rtu_proto({:parse_req, rtu_req})
    rtu_res = rtu_proto({:pack_res, cmd, val, nil})
    assert val == rtu_proto({:parse_res, cmd, rtu_res, nil})
    assert byte_size(rtu_res) == rtu_proto({:res_len, cmd})
    # tcp
    tcp_req = tcp_proto({:pack_req, cmd, 1})
    assert {cmd, 1} == tcp_proto({:parse_req, tcp_req})
    tcp_res = tcp_proto({:pack_res, cmd, val, 1})
    assert val == tcp_proto({:parse_res, cmd, tcp_res, 1})
    assert byte_size(tcp_res) == tcp_proto({:res_len, cmd})
    # conn
    {:ok, pid} = Slave.start_link(model: model)
    port = Slave.port(pid)
    {:ok, conn} = master({:open, port: port, ip: "127.0.0.1"})

    for _ <- 0..10 do
      {:ok, _, val2} = master({:exec, conn, cmd, 4000})
      assert val == val2
    end
  end

  def pp2(cmd, req, res, model0, model1) do
    assert req == request({:pack, cmd})
    assert cmd == request({:parse, req})
    assert {:ok, model1} == model({:apply, model0, cmd})
    assert res == response({:pack, cmd, nil})
    assert nil == response({:parse, cmd, res})
    # length prediction
    assert byte_size(res) == response({:length, cmd})
    # rtu
    rtu_req = rtu_proto({:pack_req, cmd, nil})
    assert {cmd, nil} == rtu_proto({:parse_req, rtu_req})
    rtu_res = rtu_proto({:pack_res, cmd, nil, nil})
    assert nil == rtu_proto({:parse_res, cmd, rtu_res, nil})
    assert byte_size(rtu_res) == rtu_proto({:res_len, cmd})
    # tcp
    tcp_req = tcp_proto({:pack_req, cmd, 1})
    assert {cmd, 1} == tcp_proto({:parse_req, tcp_req})
    tcp_res = tcp_proto({:pack_res, cmd, nil, 1})
    assert nil == tcp_proto({:parse_res, cmd, tcp_res, 1})
    assert byte_size(tcp_res) == tcp_proto({:res_len, cmd})
    # conn
    {:ok, pid} = Slave.start_link(model: model0)
    port = Slave.port(pid)
    {:ok, conn} = master({:open, port: port, ip: "127.0.0.1"})

    for _ <- 0..10 do
      {:ok, _} = master({:exec, conn, cmd, 4000})
    end
  end
end
