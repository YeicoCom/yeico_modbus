defmodule YeicoModbus.Points do
  use Agent

  def start_link(points \\ []) do
    Agent.start_link(fn -> put_reads(%{}, points) end)
  end

  def put_write(pid, point, value) do
    Agent.update(pid, &Map.put(&1, {:w, point}, value))
  end

  def get_write(pid, point, value \\ nil) do
    Agent.get_and_update(
      pid,
      &{Map.get(&1, {:w, point}), Map.put(&1, {:w, point}, value)}
    )
  end

  def put_read(pid, points) when is_list(points) do
    Agent.update(pid, fn map -> put_reads(map, points) end)
  end

  def put_read(pid, point, value) do
    Agent.update(pid, &Map.put(&1, {:r, point}, value))
  end

  def get_read(pid, point, value \\ nil) do
    Agent.get(pid, &Map.get(&1, {:r, point}, value))
  end

  defp put_reads(map, points) do
    for {point, value} <- points, reduce: map do
      map ->
        Map.put(map, {:r, point}, value)
    end
  end
end
