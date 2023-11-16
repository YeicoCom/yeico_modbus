defmodule YeicoModbus.Conn do
  alias YeicoModbus.Transport
  alias YeicoModbus.Protocol

  @to 2000

  def open(opts) do
    transm = Keyword.get(opts, :trans, YeicoModbus.Tcp.Transport)
    protom = Keyword.get(opts, :proto, YeicoModbus.Tcp.Protocol)
    tid = Protocol.next(protom, nil)

    case Transport.open(transm, opts) do
      {:ok, transi} ->
        transp = {transm, transi}
        {:ok, %{trans: transp, proto: protom, tid: tid}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def get_tid(conn), do: Map.get(conn, :tid)
  def put_tid(conn, tid), do: Map.put(conn, :tid, tid)

  def close(%{trans: trans}), do: Transport.close(trans)

  def exec(conn, cmd, timeout \\ @to)
      when is_tuple(cmd) and is_integer(timeout) do
    %{trans: trans, proto: proto, tid: tid} = conn
    conn = Map.put(conn, :tid, Protocol.next(conn.proto, tid))

    result =
      with {:ok, request, length} <- request(proto, cmd, tid),
           :ok <- Transport.write(trans, request),
           {:ok, response} <- Transport.readn(trans, length, timeout) do
        try do
          case Protocol.parse_res(proto, cmd, response, tid) do
            nil -> :ok
            values -> {:ok, values}
          end
        rescue
          _ -> {:error, {:invalid, cmd, response}}
        end
      else
        {:error, reason} ->
          {:error, reason}
      end

    {conn, result}
  end

  defp request(proto, cmd, tid) do
    try do
      request = Protocol.pack_req(proto, cmd, tid)
      length = Protocol.res_len(proto, cmd)
      {:ok, request, length}
    rescue
      _ ->
        {:error, {:invalid, cmd}}
    end
  end
end
