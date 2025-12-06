defmodule Modbus.Transport do
  @moduledoc false
  @callback open(opts :: keyword()) ::
              {:ok, conn :: any()} | {:error, reason :: any()}
  @callback readp(conn :: any()) :: {:ok, packet :: binary()} | {:error, reason :: any()}
  @callback readn(conn :: any(), count :: integer(), timeout :: integer()) ::
              {:ok, packet :: binary()} | {:error, reason :: any()}
  @callback write(conn :: any(), packet :: binary()) :: :ok | {:error, reason :: any()}
  @callback close(conn :: any()) :: :ok | {:error, reason :: any()}

  def open(mod, opts) when is_atom(mod) do
    mod.open(opts)
  end

  def open(mod, opts) when is_function(mod, 1) do
    mod.({:open, opts})
  end

  def readn({mod, conn}, count, timeout) when is_atom(mod) do
    mod.readn(conn, count, timeout)
  end

  def readn({mod, conn}, count, timeout) when is_function(mod, 1) do
    mod.({:readn, conn, count, timeout})
  end

  def readp({mod, conn}) when is_atom(mod) do
    mod.readp(conn)
  end

  def readp({mod, conn}) when is_function(mod, 1) do
    mod.({:readp, conn})
  end

  def write({mod, conn}, packet) when is_atom(mod) do
    mod.write(conn, packet)
  end

  def write({mod, conn}, packet) when is_function(mod, 1) do
    mod.({:write, conn, packet})
  end

  def close({mod, conn}) when is_atom(mod) do
    mod.close(conn)
  end

  def close({mod, conn}) when is_function(mod, 1) do
    mod.({:close, conn})
  end
end
