defmodule TextClient.Interact do

  def start() do
    CaptacionAgua.get_places()
    |> List.insert_at(-1, "Todas")
    |> display()
    |> prompt()
    |> TextClient.CaptacionAgua.format_type()

    case confirm("Continuar?[Y/n]") do
      true ->
        IO.ANSI.clear()
        start()
      false ->
        IO.puts "Finalizando..."
    end

  end

  def display(options) do
    IO.ANSI.clear()
    options
    |> Enum.with_index(1)
    |> Enum.map(fn {text, ind} -> IO.puts "#{ind}.- #{text}" end)

    options
  end

  def prompt(options) do
    count = Enum.count(options)
    input = IO.gets("Select: (1..#{count}). ")
      |> check_input

    cond do
      input == count ->
        options
      true ->
        get_select(options, input)
    end

  end

  def get_select(options, input) do
    [{ select, _}] = options
      |> Enum.with_index(1)
      |> Enum.filter(fn {_text, ind} -> ind == input end)

    select
  end

  def confirm(question) do
    IO.ANSI.clear_line()
    answer = question |> IO.gets() |> String.trim() |> String.downcase()

    case answer do
      "y" -> true
      "n" -> false
      _ -> confirm(question)
    end
  end

  def check_input({:error, reason}) do
    IO.puts "Error: #{reason}"
    exit(:normal)
  end

  def check_input(:eof) do
    IO.puts "Looks like your want to get out..."
    exit(:normal)
  end

  def check_input(input) do
    input = String.trim(input)
    cond do
      input =~ ~r/\A[0-9]*\z/ ->
        String.to_integer(input)
      true ->
        exit(:normal)
    end
  end
end
