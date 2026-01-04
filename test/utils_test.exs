defmodule Modbus.UtilsTest do
  use ExUnit.Case
  import Modbus

  test "bool_to_byte test" do
    assert 0x00 == utils({:bool_to_byte, 0})
    assert 0xFF == utils({:bool_to_byte, 1})
  end

  test "byte_count test" do
    assert 1 == utils({:byte_count, 1})
    assert 1 == utils({:byte_count, 2})
    assert 1 == utils({:byte_count, 7})
    assert 1 == utils({:byte_count, 8})
    assert 2 == utils({:byte_count, 9})
    assert 2 == utils({:byte_count, 15})
    assert 2 == utils({:byte_count, 16})
    assert 3 == utils({:byte_count, 17})
  end

  test "bin_to_bitlist test" do
    assert [1] == utils({:bin_to_bitlist, 1, <<0x13>>})
    assert [1, 1] == utils({:bin_to_bitlist, 2, <<0x13>>})
    assert [1, 1, 0] == utils({:bin_to_bitlist, 3, <<0x13>>})
    assert [1, 1, 0, 0] == utils({:bin_to_bitlist, 4, <<0x13>>})
    assert [1, 1, 0, 0, 1] == utils({:bin_to_bitlist, 5, <<0x13>>})
    assert [1, 1, 0, 0, 1, 0] == utils({:bin_to_bitlist, 6, <<0x13>>})
    assert [1, 1, 0, 0, 1, 0, 0] == utils({:bin_to_bitlist, 7, <<0x13>>})
    assert [1, 1, 0, 0, 1, 0, 0, 0] == utils({:bin_to_bitlist, 8, <<0x13>>})
    assert [1, 1, 0, 0, 1, 0, 0, 0, 1] == utils({:bin_to_bitlist, 9, <<0x13, 0x01>>})
  end

  test "bin_to_reglist test" do
    assert [0x0102] == utils({:bin_to_reglist, 1, <<0x01, 0x02>>})
    assert [0x0102, 0x0304] == utils({:bin_to_reglist, 2, <<0x01, 0x02, 0x03, 0x04>>})
  end
end
