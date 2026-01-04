defmodule Modbus.TcpTest do
  use ExUnit.Case
  import Modbus

  # http://www.tahapaksu.com/crc/
  # https://www.lammertbies.nl/comm/info/crc-calculation.html
  test "wrap test" do
    p(0, <<>>, <<0, 0, 0, 0, 0, 0>>)
    p(1, <<0>>, <<0, 1, 0, 0, 0, 1, 0>>)
    p(2, <<0, 1>>, <<0, 2, 0, 0, 0, 2, 0, 1>>)
    p(3, <<0, 1, 2>>, <<0, 3, 0, 0, 0, 3, 0, 1, 2>>)
    p(4, <<0, 1, 2, 3>>, <<0, 4, 0, 0, 0, 4, 0, 1, 2, 3>>)
  end

  defp p(transid, payload, packet) do
    assert packet == payload |> tcp_wrap(transid)
    assert {payload, transid} == packet |> tcp_unwrap()
  end

  test "transaction id wraps around 0xFFFF" do
    # run with: mix slave

    # start your slave with a shared model
    model = %{0x50 => %{{:c, 0x5152} => 0}}

    {:ok, slave} = Slave.start_link(model: model)
    # get the assigned tcp port
    port = Slave.port(slave)

    # interact with it
    {:ok, conn} = modbus({:open, ip: "127.0.0.1", port: port})
    ini = 0xFFF8
    conn = modbus({:tid, conn, ini})

    conn =
      for tid <- ini..(ini + 0x10), reduce: conn do
        conn ->
          wtid = Bitwise.band(tid, 0xFFFF)
          assert wtid == modbus({:tid, conn})
          {:ok, conn} = modbus({:exec, conn, {:fc, 0x50, 0x5152, 0}, 4000})
          conn
      end

    :ok = modbus({:close, conn})
    :ok = Slave.stop(slave)
  end
end
