defmodule TextClient.CaptacionAgua do
  
  def format(place) when is_bitstring(place) do
    # format_output(place)
    format_output_v(place)
  end

  def format(places) when is_list(places) do
    places
    |> Enum.take(Enum.count(places) - 1)
    |> Enum.map(&format_output_v(&1))
    # |> Enum.map(&format_output(&1))
  end

  def format_output(place) do
    [data] = CaptacionAgua.get_data(place)

    IO.puts ""
    String.pad_leading(data.place, 90, " ") |> IO.puts
    IO.puts ""

    format_list(data.years)          |> format_line("Years")         |> IO.puts
    String.pad_leading("", 179, "-") |> IO.puts
    format_list(data.desalacion)     |> format_line("Desalacion")    |> IO.puts
    format_list(data.subterraneas)   |> format_line("Subterraneas")  |> IO.puts
    format_list(data.superficiales)  |> format_line("Superficiales") |> IO.puts
    String.pad_leading("", 179, "-") |> IO.puts
    format_list(data.total)          |> format_line("Total")         |> IO.puts
  end

  def format_output_v(place) do
    [data] = CaptacionAgua.get_data(place)

    IO.puts ""
    String.pad_leading(data.place, 35, " ") |> IO.puts
    IO.puts ""

    year = String.pad_leading("Years", 6, " ")
    desalacion = String.pad_leading("Desalacion", 12, " ")
    subterraneas = String.pad_leading("Subterraneas", 14, " ")
    superficiales = String.pad_leading("Superficiales", 15, " ")
    total = String.pad_leading("Total", 15, " ")
    IO.puts "#{year} #{desalacion} #{subterraneas} #{superficiales} #{total}"
    String.pad_leading("", 66, "-") |> IO.puts()
    format_output_vertical(data.years, data.desalacion, data.subterraneas, data.superficiales, data.total)
  end

  def format_output_vertical([], [], [], [], []) do
    String.pad_leading("", 66, "-")
    |> IO.puts()
  end

  def format_output_vertical([hyear|tyear], [hdesal|tdesal], [hsubter|tsubter], [hsuperf|tsuperf], [htotal|ttotal]) do
    year = String.pad_leading(hyear, 6, " ")
    desalacion = String.pad_leading(hdesal, 12, " ")
    subterraneas = String.pad_leading(hsubter, 14, " ")
    superficiales = String.pad_leading(hsuperf, 15, " ")
    total = String.pad_leading(htotal, 15, " ")
    IO.puts "#{year} #{desalacion} #{subterraneas} #{superficiales} #{total}"

    format_output_vertical(tyear, tdesal, tsubter, tsuperf, ttotal)
  end

  def format_list(list) do
    Enum.map(list, fn x -> String.pad_leading(x, 10, " ") end)
    |> Enum.join("|")
  end

  def format_line(texto, msg) do
    String.pad_trailing(msg, 14, " ") <> texto
  end

end
