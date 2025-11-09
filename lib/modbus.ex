defmodule Modbus do
  alias Modbus.Transport
  alias Modbus.Protocol

  @to 2000

  def open(opts) do
    transm = Keyword.get(opts, :trans, Modbus.Tcp.Transport)
    protom = Keyword.get(opts, :proto, Modbus.Tcp.Protocol)
    tid = Protocol.next(protom, nil)

    case Transport.open(transm, opts) do
      {:ok, transi} ->
        transp = {transm, transi}
        {:ok, %{trans: transp, proto: protom, tid: tid}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def close(%{trans: trans}), do: Transport.close(trans)

  def exec(conn, cmd, timeout \\ @to)
      when is_tuple(cmd) and is_integer(timeout) do
    %{trans: trans, proto: proto, tid: tid} = conn
    conn = Map.put(conn, :tid, Protocol.next(proto, tid))

    with {:ok, request, length} <- request(proto, cmd, tid),
         :ok <- Transport.write(trans, request),
         {:ok, resp} <- Transport.readn(trans, length, timeout) do
      case parse(proto, cmd, resp, tid) do
        {:error, error} -> {:error, conn, error}
        nil -> {:ok, conn}
        values -> {:ok, conn, values}
      end
    else
      {:error, error} ->
        {:error, conn, error}
    end
  end

  defp request(proto, cmd, tid) do
    try do
      request = Protocol.pack_req(proto, cmd, tid)
      length = Protocol.res_len(proto, cmd)
      {:ok, request, length}
    rescue
      _ ->
        {:error, {:request, cmd: cmd, tid: tid}}
    end
  end

  defp parse(proto, cmd, resp, tid) do
    try do
      Protocol.parse_res(proto, cmd, resp, tid)
    rescue
      _ -> {:error, {:parse, cmd: cmd, tid: tid, resp: resp}}
    end
  end

  # for testing
  def tid(conn), do: Map.get(conn, :tid)
  def tid(conn, tid), do: Map.put(conn, :tid, tid)
end
