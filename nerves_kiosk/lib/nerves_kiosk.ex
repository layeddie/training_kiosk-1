defmodule NervesKiosk do
  @moduledoc """
  Documentation for NervesKiosk.
  """
  require Logger

  @doc """
  Hello world.

  ## Examples

      iex> NervesKiosk.hello
      :world

  """
  def hello do
    Logger.debug("Hello")
    :world
  end
end
