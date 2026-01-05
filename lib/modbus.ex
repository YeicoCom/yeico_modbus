toms = 4000

hi_array =
  """
  [
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81,
    0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
    0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01,
    0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81,
    0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
    0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01,
    0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81,
    0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
    0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01,
    0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81,
    0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
    0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01,
    0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81,
    0x40
  ]
  """
  |> Code.eval_string()
  |> elem(0)
  |> :array.from_list()

lo_array =
  """
  [
  0x00, 0xC0, 0xC1, 0x01, 0xC3, 0x03, 0x02, 0xC2, 0xC6, 0x06, 0x07, 0xC7, 0x05, 0xC5, 0xC4,
  0x04, 0xCC, 0x0C, 0x0D, 0xCD, 0x0F, 0xCF, 0xCE, 0x0E, 0x0A, 0xCA, 0xCB, 0x0B, 0xC9, 0x09,
  0x08, 0xC8, 0xD8, 0x18, 0x19, 0xD9, 0x1B, 0xDB, 0xDA, 0x1A, 0x1E, 0xDE, 0xDF, 0x1F, 0xDD,
  0x1D, 0x1C, 0xDC, 0x14, 0xD4, 0xD5, 0x15, 0xD7, 0x17, 0x16, 0xD6, 0xD2, 0x12, 0x13, 0xD3,
  0x11, 0xD1, 0xD0, 0x10, 0xF0, 0x30, 0x31, 0xF1, 0x33, 0xF3, 0xF2, 0x32, 0x36, 0xF6, 0xF7,
  0x37, 0xF5, 0x35, 0x34, 0xF4, 0x3C, 0xFC, 0xFD, 0x3D, 0xFF, 0x3F, 0x3E, 0xFE, 0xFA, 0x3A,
  0x3B, 0xFB, 0x39, 0xF9, 0xF8, 0x38, 0x28, 0xE8, 0xE9, 0x29, 0xEB, 0x2B, 0x2A, 0xEA, 0xEE,
  0x2E, 0x2F, 0xEF, 0x2D, 0xED, 0xEC, 0x2C, 0xE4, 0x24, 0x25, 0xE5, 0x27, 0xE7, 0xE6, 0x26,
  0x22, 0xE2, 0xE3, 0x23, 0xE1, 0x21, 0x20, 0xE0, 0xA0, 0x60, 0x61, 0xA1, 0x63, 0xA3, 0xA2,
  0x62, 0x66, 0xA6, 0xA7, 0x67, 0xA5, 0x65, 0x64, 0xA4, 0x6C, 0xAC, 0xAD, 0x6D, 0xAF, 0x6F,
  0x6E, 0xAE, 0xAA, 0x6A, 0x6B, 0xAB, 0x69, 0xA9, 0xA8, 0x68, 0x78, 0xB8, 0xB9, 0x79, 0xBB,
  0x7B, 0x7A, 0xBA, 0xBE, 0x7E, 0x7F, 0xBF, 0x7D, 0xBD, 0xBC, 0x7C, 0xB4, 0x74, 0x75, 0xB5,
  0x77, 0xB7, 0xB6, 0x76, 0x72, 0xB2, 0xB3, 0x73, 0xB1, 0x71, 0x70, 0xB0, 0x50, 0x90, 0x91,
  0x51, 0x93, 0x53, 0x52, 0x92, 0x96, 0x56, 0x57, 0x97, 0x55, 0x95, 0x94, 0x54, 0x9C, 0x5C,
  0x5D, 0x9D, 0x5F, 0x9F, 0x9E, 0x5E, 0x5A, 0x9A, 0x9B, 0x5B, 0x99, 0x59, 0x58, 0x98, 0x88,
  0x48, 0x49, 0x89, 0x4B, 0x8B, 0x8A, 0x4A, 0x4E, 0x8E, 0x8F, 0x4F, 0x8D, 0x4D, 0x4C, 0x8C,
  0x44, 0x84, 0x85, 0x45, 0x87, 0x47, 0x46, 0x86, 0x82, 0x42, 0x43, 0x83, 0x41, 0x81, 0x80,
  0x40
  ]
  """
  |> Code.eval_string()
  |> elem(0)
  |> :array.from_list()

crc_p = fn
  {_self, <<>>, hi, lo} ->
    <<hi, lo>>

  {self, data, hi, lo} ->
    <<first, tail::binary>> = data
    index = Bitwise.bxor(lo, first)
    nhi = :array.get(index, hi_array)
    lo = Bitwise.bxor(hi, nhi)
    self.({self, tail, :array.get(index, lo_array), lo})
end

crc = fn
  data -> crc_p.({crc_p, data, 0xFF, 0xFF})
end

# https://www.h-schmidt.net/FloatConverter/Float.html.

float_p = fn
  {_self, _, [], _} ->
    []

  {self, :from, [w0, w1 | tail], endianness} ->
    [self.({self, :from, w0, w1, endianness}) | self.({self, :from, tail, endianness})]

  {_self, :from, w0, w1, :be} ->
    <<value::float-32>> = <<w0::16, w1::16>>
    value

  {_self, :from, w0, w1, :le} ->
    <<value::float-32>> = <<w1::16, w0::16>>
    value

  {self, :to, [f | tail], endianness} ->
    [w0, w1] = self.({self, :to, f, endianness})
    [w0, w1 | self.({self, :to, tail, endianness})]

  {_self, :to, f, :be} ->
    <<w0::16, w1::16>> = <<f::float-32>>
    [w0, w1]

  {_self, :to, f, :le} ->
    <<w0::16, w1::16>> = <<f::float-32>>
    [w1, w0]
end

float = fn
  {:from_be, list_of_regs} -> float_p.({float_p, :from, list_of_regs, :be})
  {:from_le, list_of_regs} -> float_p.({float_p, :from, list_of_regs, :le})
  {:to_be, list_of_floats} -> float_p.({float_p, :to, list_of_floats, :be})
  {:to_le, list_of_floats} -> float_p.({float_p, :to, list_of_floats, :le})
end

utils = fn
  {_self, :byte_count, count} ->
    div(count - 1, 8) + 1

  {_self, :bool_to_byte, value} ->
    # enforce 0 or 1 only
    case value do
      0 -> 0x00
      1 -> 0xFF
    end

  {_self, :bin_to_bitlist, count, <<b7::1, b6::1, b5::1, b4::1, b3::1, b2::1, b1::1, b0::1>>}
  when count <= 8 ->
    Enum.take([b0, b1, b2, b3, b4, b5, b6, b7], count)

  {self, :bin_to_bitlist, count,
   <<b7::1, b6::1, b5::1, b4::1, b3::1, b2::1, b1::1, b0::1, tail::binary>>} ->
    [b0, b1, b2, b3, b4, b5, b6, b7] ++ self.({self, :bin_to_bitlist, count - 8, tail})

  {_self, :bin_to_reglist, 1, <<register::16>>} ->
    [register]

  {self, :bin_to_reglist, count, <<register::16, tail::binary>>} ->
    [register | self.({self, :bin_to_reglist, count - 1, tail})]

  {self, :bitlist_to_bin, values} ->
    lists = Enum.chunk_every(values, 8, 8, [0, 0, 0, 0, 0, 0, 0, 0])

    list =
      for list8 <- lists do
        [v0, v1, v2, v3, v4, v5, v6, v7] =
          for b <- list8 do
            # enforce 0 or 1 only
            self.({self, :bool_to_byte, b})
          end

        <<v7::1, v6::1, v5::1, v4::1, v3::1, v2::1, v1::1, v0::1>>
      end

    :erlang.iolist_to_binary(list)

  {_self, :reglist_to_bin, values} ->
    list =
      for value <- values do
        <<value::size(16)>>
      end

    :erlang.iolist_to_binary(list)
end

request_p = fn
  {:reads, _type, slave, function, address, count} ->
    <<slave, function, address::16, count::16>>

  {:write, :d, slave, function, address, value} ->
    <<slave, function, address::16, utils.({utils, :bool_to_byte, value}), 0x00>>

  {:write, :a, slave, function, address, value} ->
    <<slave, function, address::16, value::16>>

  {:writes, :d, slave, function, address, values} ->
    count = Enum.count(values)
    bytes = utils.({utils, :byte_count, count})
    data = utils.({utils, :bitlist_to_bin, values})
    <<slave, function, address::16, count::16, bytes, data::binary>>

  {:writes, :a, slave, function, address, values} ->
    count = Enum.count(values)
    bytes = 2 * count
    data = utils.({utils, :reglist_to_bin, values})
    <<slave, function, address::16, count::16, bytes, data::binary>>
end

request = fn
  {:pack, {:rc, slave, address, count}} ->
    request_p.({:reads, :d, slave, 1, address, count})

  {:pack, {:ri, slave, address, count}} ->
    request_p.({:reads, :d, slave, 2, address, count})

  {:pack, {:rhr, slave, address, count}} ->
    request_p.({:reads, :a, slave, 3, address, count})

  {:pack, {:rir, slave, address, count}} ->
    request_p.({:reads, :a, slave, 4, address, count})

  {:pack, {:fc, slave, address, value}} when is_integer(value) ->
    request_p.({:write, :d, slave, 5, address, value})

  {:pack, {:phr, slave, address, value}} when is_integer(value) ->
    request_p.({:write, :a, slave, 6, address, value})

  {:pack, {:fc, slave, address, values}} when is_list(values) ->
    request_p.({:writes, :d, slave, 15, address, values})

  {:pack, {:phr, slave, address, values}} when is_list(values) ->
    request_p.({:writes, :a, slave, 16, address, values})

  {:parse, <<slave, 1, address::16, count::16>>} ->
    {:rc, slave, address, count}

  {:parse, <<slave, 2, address::16, count::16>>} ->
    {:ri, slave, address, count}

  {:parse, <<slave, 3, address::16, count::16>>} ->
    {:rhr, slave, address, count}

  {:parse, <<slave, 4, address::16, count::16>>} ->
    {:rir, slave, address, count}

  {:parse, <<slave, 5, address::16, 0x00, 0x00>>} ->
    {:fc, slave, address, 0}

  {:parse, <<slave, 5, address::16, 0xFF, 0x00>>} ->
    {:fc, slave, address, 1}

  {:parse, <<slave, 6, address::16, value::16>>} ->
    {:phr, slave, address, value}

  {:parse, <<slave, 15, address::16, count::16, bytes, data::binary>>} ->
    ^bytes = utils.({utils, :byte_count, count})
    values = utils.({utils, :bin_to_bitlist, count, data})
    {:fc, slave, address, values}

  {:parse, <<slave, 16, address::16, count::16, bytes, data::binary>>} ->
    ^bytes = 2 * count
    values = utils.({utils, :bin_to_reglist, count, data})
    {:phr, slave, address, values}

  {:length, {:rc, _slave, _address, _count}} ->
    6

  {:length, {:ri, _slave, _address, _count}} ->
    6

  {:length, {:rhr, _slave, _address, _count}} ->
    6

  {:length, {:rir, _slave, _address, _count}} ->
    6

  {:length, {:fc, _slave, _address, value}} when is_integer(value) ->
    6

  {:length, {:phr, _slave, _address, value}} when is_integer(value) ->
    6

  {:length, {:fc, _slave, _address, values}} when is_list(values) ->
    7 + utils.({utils, :byte_count, Enum.count(values)})

  {:length, {:phr, _slave, _address, values}} when is_list(values) ->
    7 + 2 * Enum.count(values)
end

response_p = fn
  {:reads, slave, function, data} ->
    bytes = :erlang.byte_size(data)
    <<slave, function, bytes, data::binary>>

  {:write, :d, slave, function, address, value} ->
    <<slave, function, address::16, utils.({utils, :bool_to_byte, value}), 0x00>>

  {:write, :a, slave, function, address, value} ->
    <<slave, function, address::16, value::16>>

  {:writes, _type, slave, function, address, values} ->
    count = Enum.count(values)
    <<slave, function, address::16, count::16>>
end

response = fn
  {:pack, {:rc, slave, _address, count}, values} ->
    ^count = Enum.count(values)
    data = utils.({utils, :bitlist_to_bin, values})
    response_p.({:reads, slave, 1, data})

  {:pack, {:ri, slave, _address, count}, values} ->
    ^count = Enum.count(values)
    data = utils.({utils, :bitlist_to_bin, values})
    response_p.({:reads, slave, 2, data})

  {:pack, {:rhr, slave, _address, count}, values} ->
    ^count = Enum.count(values)
    data = utils.({utils, :reglist_to_bin, values})
    response_p.({:reads, slave, 3, data})

  {:pack, {:rir, slave, _address, count}, values} ->
    ^count = Enum.count(values)
    data = utils.({utils, :reglist_to_bin, values})
    response_p.({:reads, slave, 4, data})

  {:pack, {:fc, slave, address, value}, nil} when is_integer(value) ->
    response_p.({:write, :d, slave, 5, address, value})

  {:pack, {:phr, slave, address, value}, nil} when is_integer(value) ->
    response_p.({:write, :a, slave, 6, address, value})

  {:pack, {:fc, slave, address, values}, nil} when is_list(values) ->
    response_p.({:writes, :d, slave, 15, address, values})

  {:pack, {:phr, slave, address, values}, nil} when is_list(values) ->
    response_p.({:writes, :a, slave, 16, address, values})

  {:parse, {:rc, slave, _address, count}, <<slave, 1, bytes, data::binary>>} ->
    ^bytes = utils.({utils, :byte_count, count})
    utils.({utils, :bin_to_bitlist, count, data})

  {:parse, {:ri, slave, _address, count}, <<slave, 2, bytes, data::binary>>} ->
    ^bytes = utils.({utils, :byte_count, count})
    utils.({utils, :bin_to_bitlist, count, data})

  {:parse, {:rhr, slave, _address, count}, <<slave, 3, bytes, data::binary>>} ->
    ^bytes = 2 * count
    utils.({utils, :bin_to_reglist, count, data})

  {:parse, {:rir, slave, _address, count}, <<slave, 4, bytes, data::binary>>} ->
    ^bytes = 2 * count
    utils.({utils, :bin_to_reglist, count, data})

  {:parse, {:fc, slave, address, 0}, <<slave, 5, address::16, 0x00, 0x00>>} ->
    nil

  {:parse, {:fc, slave, address, 1}, <<slave, 5, address::16, 0xFF, 0x00>>} ->
    nil

  {:parse, {:phr, slave, address, value}, <<slave, 6, address::16, value::16>>} ->
    nil

  {:parse, {:fc, slave, address, values}, <<slave, 15, address::16, count::16>>} ->
    ^count = Enum.count(values)
    nil

  {:parse, {:phr, slave, address, values}, <<slave, 16, address::16, count::16>>} ->
    ^count = Enum.count(values)
    nil

  {:length, {:rc, _slave, _address, count}} ->
    3 + utils.({utils, :byte_count, count})

  {:length, {:ri, _slave, _address, count}} ->
    3 + utils.({utils, :byte_count, count})

  {:length, {:rhr, _slave, _address, count}} ->
    3 + 2 * count

  {:length, {:rir, _slave, _address, count}} ->
    3 + 2 * count

  {:length, {:fc, _slave, _address, _}} ->
    6

  {:length, {:phr, _slave, _address, _}} ->
    6
end

# CRC is little endian
# http://modbus.org/docs/Modbus_over_serial_line_V1_02.pdf page 13

rtu_proto_p = fn
  {:wrap, payload} ->
    <<crc_hi, crc_lo>> = crc.(payload)
    <<payload::binary, crc_lo, crc_hi>>

  {:unwrap, data} ->
    size = :erlang.byte_size(data) - 2
    <<payload::binary-size(size), crc_lo, crc_hi>> = data
    <<^crc_hi, ^crc_lo>> = crc.(payload)
    payload
end

rtu_proto = fn
  {:next, _} ->
    nil

  {:pack_req, cmd, _tid} ->
    rtu_proto_p.({:wrap, request.({:pack, cmd})})

  {:res_len, cmd} ->
    response.({:length, cmd}) + 2

  {:parse_res, cmd, wraped, _tid} ->
    response.({:parse, cmd, rtu_proto_p.({:unwrap, wraped})})

  {:parse_req, wraped} ->
    {request.({:parse, rtu_proto_p.({:unwrap, wraped})}), nil}

  {:pack_res, cmd, values, _tid} ->
    rtu_proto_p.({:wrap, response.({:pack, cmd, values})})
end

tcp_proto_p = fn
  {:wrap, payload, tid} ->
    size = :erlang.byte_size(payload)
    <<tid::16, 0, 0, size::16, payload::binary>>

  {:unwrap, <<tid::16, 0, 0, size::16, payload::binary>>} ->
    ^size = :erlang.byte_size(payload)
    {payload, tid}

  {:unwrap, <<tid::16, 0, 0, size::16, payload::binary>>, tid} ->
    ^size = :erlang.byte_size(payload)
    payload
end

tcp_proto = fn
  {:next, tid} ->
    case tid do
      nil -> 0
      _ -> Bitwise.band(tid + 1, 0xFFFF)
    end

  {:pack_req, cmd, tid} ->
    tcp_proto_p.({:wrap, request.({:pack, cmd}), tid})

  {:res_len, cmd} ->
    response.({:length, cmd}) + 6

  {:parse_res, cmd, wraped, tid} ->
    response.({:parse, cmd, tcp_proto_p.({:unwrap, wraped, tid})})

  {:parse_req, wraped} ->
    {pack, transid} = tcp_proto_p.({:unwrap, wraped})
    {request.({:parse, pack}), transid}

  {:pack_res, cmd, values, tid} ->
    tcp_proto_p.({:wrap, response.({:pack, cmd, values}), tid})
end

tcp_trans_p = fn
  {:parse, ip} ->
    :inet.parse_address(~c"#{ip}") |> elem(1)
end

tcp_trans = fn
  {:open, opts} ->
    ip = Keyword.fetch!(opts, :ip)
    ip = if is_binary(ip), do: tcp_trans_p.({:parse, ip}), else: ip
    port = Keyword.fetch!(opts, :port)
    timeout = Keyword.get(opts, :timeout, toms)
    opts = [:binary, packet: :raw, active: false]
    :gen_tcp.connect(ip, port, opts, timeout)

  {:readn, socket, count, timeout} ->
    :gen_tcp.recv(socket, count, timeout)

  {:readp, socket} ->
    :gen_tcp.recv(socket, 0)

  {:write, socket, packet} ->
    # discard before send
    :gen_tcp.recv(socket, 0, 0)
    :gen_tcp.send(socket, packet)

  {:close, socket} ->
    :gen_tcp.close(socket)
end

model_p = fn
  {self, :reads, state, {slave, type, address, count}} ->
    case self.({self, :check_request, state, {slave, type, address, count}}) do
      true ->
        map = Map.fetch!(state, slave)
        addr_end = address + count - 1

        list =
          for point <- address..addr_end do
            Map.fetch!(map, {type, point})
          end

        {:ok, state, list}

      false ->
        {:error, state}
    end

  {self, :write, state, {slave, type, address, value}} ->
    case self.({self, :check_request, state, {slave, type, address, 1}}) do
      true ->
        cmap = Map.fetch!(state, slave)
        nmap = Map.put(cmap, {type, address}, value)
        {:ok, Map.put(state, slave, nmap)}

      false ->
        {:error, state}
    end

  {self, :writes, state, {slave, type, address, values}} ->
    count = length(values)

    case self.({self, :check_request, state, {slave, type, address, count}}) do
      true ->
        cmap = Map.fetch!(state, slave)
        addr_end = address + count

        {^addr_end, nmap} =
          Enum.reduce(values, {address, cmap}, fn value, {i, map} ->
            {i + 1, Map.put(map, {type, i}, value)}
          end)

        {:ok, Map.put(state, slave, nmap)}

      false ->
        {:error, state}
    end

  # for testing
  {_self, :check_request, state, {slave, type, addr, count}} ->
    map = Map.get(state, slave)

    case map do
      nil ->
        false

      _ ->
        addr_end = addr + count - 1

        Enum.all?(addr..addr_end, fn addr ->
          Map.has_key?(map, {type, addr})
        end)
    end
end

model = fn
  {:apply, state, {:rc, slave, address, count}} when is_integer(address) and is_integer(count) ->
    model_p.({model_p, :reads, state, {slave, :c, address, count}})

  {:apply, state, {:ri, slave, address, count}} when is_integer(address) and is_integer(count) ->
    model_p.({model_p, :reads, state, {slave, :i, address, count}})

  {:apply, state, {:rhr, slave, address, count}} when is_integer(address) and is_integer(count) ->
    model_p.({model_p, :reads, state, {slave, :hr, address, count}})

  {:apply, state, {:rir, slave, address, count}} when is_integer(address) and is_integer(count) ->
    model_p.({model_p, :reads, state, {slave, :ir, address, count}})

  {:apply, state, {:fc, slave, address, value}} when is_integer(address) and not is_list(value) ->
    model_p.({model_p, :write, state, {slave, :c, address, value}})

  {:apply, state, {:fc, slave, address, values}} when is_integer(address) and is_list(values) ->
    model_p.({model_p, :writes, state, {slave, :c, address, values}})

  {:apply, state, {:phr, slave, address, value}}
  when is_integer(address) and not is_list(value) ->
    model_p.({model_p, :write, state, {slave, :hr, address, value}})

  {:apply, state, {:phr, slave, address, values}} when is_integer(address) and is_list(values) ->
    model_p.({model_p, :writes, state, {slave, :hr, address, values}})

  # for testing
  {:check_request, state, {slave, type, addr, count}} ->
    model_p.({model_p, :check_request, state, {slave, type, addr, count}})
end

master_p = fn
  {:request, proto, cmd, tid} ->
    try do
      request = proto.({:pack_req, cmd, tid})
      length = proto.({:res_len, cmd})
      {:ok, request, length}
    rescue
      ex ->
        {:error, {:request, rescue: ex, stack: __STACKTRACE__, cmd: cmd, tid: tid}}
    end

  {:parse, proto, cmd, resp, tid} ->
    try do
      proto.({:parse_res, cmd, resp, tid})
    rescue
      ex -> {:error, {:parse, rescue: ex, stack: __STACKTRACE__, cmd: cmd, tid: tid, resp: resp}}
    end
end

master = fn
  {:open, opts} ->
    proto = Keyword.get(opts, :proto, tcp_proto)
    trans = Keyword.get(opts, :trans, tcp_trans)
    tid = proto.({:next, nil})

    case trans.({:open, opts}) do
      {:ok, tstate} ->
        {:ok, %{trans: trans, proto: proto, tid: tid, tstate: tstate}}

      {:error, reason} ->
        {:error, reason}
    end

  {:close, %{trans: trans, tstate: tstate}} ->
    trans.({:close, tstate})

  {:exec, conn = %{trans: trans, proto: proto, tid: tid, tstate: tstate}, cmd, timeout}
  when is_integer(timeout) ->
    conn = Map.put(conn, :tid, proto.({:next, tid}))

    with {:ok, request, length} <- master_p.({:request, proto, cmd, tid}),
         :ok <- trans.({:write, tstate, request}),
         {:ok, resp} <- trans.({:readn, tstate, length, timeout}) do
      case master_p.({:parse, proto, cmd, resp, tid}) do
        {:error, error} -> {:error, conn, error}
        nil -> {:ok, conn}
        values -> {:ok, conn, values}
      end
    else
      {:error, error} ->
        {:error, conn, error}
    end

  # for testing
  {:tid, conn} ->
    Map.get(conn, :tid)

  {:tid, conn, tid} ->
    Map.put(conn, :tid, tid)
end

%{
  float: float,
  model: model,
  master: master,
  rtu_proto: rtu_proto,
  tcp_proto: tcp_proto,
  tcp_trans: tcp_trans
}
