defmodule Modbus.FloatTest do
  use ExUnit.Case
  import Modbus

  # https://www.h-schmidt.net/FloatConverter/Float.html
  # endianess tested agains opto22 analog modules
  test "float convertion test" do
    assert [0xC0A0, 0x0000] == float({:to_be, [-5.0]})
    assert [0x0000, 0xC0A0] == float({:to_le, [-5.0]})
    assert [0x40A0, 0x0000] == float({:to_be, [+5.0]})
    assert [0x0000, 0x40A0] == float({:to_le, [+5.0]})
    assert [0xC0A0, 0x0000, 0x40A0, 0x0000] == float({:to_be, [-5.0, +5.0]})
    assert [0x0000, 0xC0A0, 0x0000, 0x40A0] == float({:to_le, [-5.0, +5.0]})
    assert [-5.0] == float({:from_be, [0xC0A0, 0x0000]})
    assert [-5.0] == float({:from_le, [0x0000, 0xC0A0]})
    assert [+5.0] == float({:from_be, [0x40A0, 0x0000]})
    assert [+5.0] == float({:from_le, [0x0000, 0x40A0]})
    assert [-5.0, +5.0] == float({:from_be, [0xC0A0, 0x0000, 0x40A0, 0x0000]})
    assert [-5.0, +5.0] == float({:from_le, [0x0000, 0xC0A0, 0x0000, 0x40A0]})
  end
end
