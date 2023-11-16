defmodule YeicoModbus.Float do
  # https://www.h-schmidt.net/FloatConverter/Float.html.
  def from_be(list_of_regs), do: from(list_of_regs, :be)

  def from_le(list_of_regs), do: from(list_of_regs, :le)

  def to_be(list_of_floats), do: to(list_of_floats, :be)

  def to_le(list_of_floats), do: to(list_of_floats, :le)

  defp from([], _), do: []

  defp from([w0, w1 | tail], endianness) do
    [from(w0, w1, endianness) | from(tail, endianness)]
  end

  defp from(w0, w1, :be) do
    <<value::float-32>> = <<w0::16, w1::16>>
    value
  end

  defp from(w0, w1, :le) do
    <<value::float-32>> = <<w1::16, w0::16>>
    value
  end

  defp to([], _), do: []

  defp to([f | tail], endianness) do
    [w0, w1] = to(f, endianness)
    [w0, w1 | to(tail, endianness)]
  end

  defp to(f, :be) do
    <<w0::16, w1::16>> = <<f::float-32>>
    [w0, w1]
  end

  defp to(f, :le) do
    <<w0::16, w1::16>> = <<f::float-32>>
    [w1, w0]
  end
end
