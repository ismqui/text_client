defmodule TextClient.Application do
  use Application

  def start(_type, _args) do
    TextClient.start()
  end
end
