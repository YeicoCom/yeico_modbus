defmodule YeicoModbus.Master do
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(opts) do
    put(:opts, opts)
    {:ok, :state}
  end

  def exec(pid, cmd), do: GenServer.call(pid, {:exec, cmd})
  def close(pid), do: GenServer.call(pid, :close)

  def handle_call({:exec, cmd}, _from, state) do
    opts = get(:opts)

    result =
      YeicoModbus.with(:master, opts, fn master ->
        master.(cmd)
      end)

    {:reply, result, state}
  end

  def handle_call(:close, _from, state) do
    {:reply, YeicoModbus.close(:master), state}
  end

  defp get(key), do: Process.get({__MODULE__, key})
  defp put(key, value), do: Process.put({__MODULE__, key}, value)
end
