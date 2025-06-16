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
      try do
        case Protocol.parse_res(proto, cmd, resp, tid) do
          nil -> {:ok, conn}
          values -> {:ok, conn, values}
        end
      rescue
        _ -> {:error, conn, {:invalid, cmd: cmd, resp: resp}}
      end
    else
      {:error, reason} ->
        {:error, conn, reason}
    end
  end

  defp request(proto, cmd, tid) do
    try do
      request = Protocol.pack_req(proto, cmd, tid)
      length = Protocol.res_len(proto, cmd)
      {:ok, request, length}
    rescue
      _ ->
        {:error, {:invalid, cmd: cmd}}
    end
  end

  # for testing
  def tid(conn), do: Map.get(conn, :tid)
  def tid(conn, tid), do: Map.put(conn, :tid, tid)
end
