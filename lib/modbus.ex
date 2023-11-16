defmodule YeicoModbus do
  alias YeicoModbus.Conn

  def with(key, opts, callback) do
    case get(key) do
      nil -> put(key, Conn.open(opts))
      {:error, _} -> put(key, Conn.open(opts))
      {:ok, _} -> :nop
    end

    # no autoclose on error
    # only autoclose callback on exception
    master = fn cmd ->
      {:ok, conn} = get(key)
      {conn, result} = Conn.exec(conn, cmd)
      put(key, {:ok, conn})
      result
    end

    case get(key) do
      {:error, reason} ->
        {:error, reason}

      {:ok, _} ->
        try do
          callback.(master)
        rescue
          e ->
            {:ok, conn} = get(key)
            Conn.close(conn)
            delete(key)
            {:error, e}
        end
    end
  end

  def close(key) do
    case get(key) do
      {:ok, conn} ->
        Conn.close(conn)
        delete(key)
        :ok

      _ ->
        :ok
    end
  end

  defp get(key), do: Process.get({__MODULE__, key})
  defp delete(key), do: Process.delete({__MODULE__, key})
  defp put(key, value), do: Process.put({__MODULE__, key}, value)
end
