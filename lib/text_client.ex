defmodule TextClient do
  @moduledoc """
  Documentation for TextClient.
  """

  @doc """
  """
  defdelegate  start(), to: TextClient.Interact
  
end
