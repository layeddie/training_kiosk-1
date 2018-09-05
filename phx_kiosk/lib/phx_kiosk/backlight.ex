defmodule PhxKiosk.Backlight do
  use GenServer

  @brightness_file "/sys/class/backlight/rpi_backlight/brightness"

  # Public API
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def set_brightness(value) when value >= 0 and value <= 255 do
    GenServer.call(__MODULE__, {:brightness, value})
  end

  def set_brightness(_value), do: {:error, "Value must be between 0 and 255"}

  def brightness do
    GenServer.call(__MODULE__, :brightness)
  end

  # GenServer callbacks
  def init(_opts) do
    {:ok, 255}
  end

  def handle_call(:brightness, _from, brightness) do
    {:reply, brightness, brightness}
  end

  def handle_call({:brightness, value}, _from, _brightness) do
    if File.exists?(@brightness_file) do
      value = value |> round() |> to_string()
      File.write(@brightness_file, value)
    end
    {:reply, value, value}
  end
end
