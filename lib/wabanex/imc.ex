defmodule Wabanex.IMC do
  def calculate(%{"filename" => filename}) do
    case File.read(filename) do
      {:error, _reason} -> {:error, "error while opening file"}
      {:ok, content} -> {:ok, handle_content(content)}
    end
  end

  defp handle_content(content) do
    content
    |> String.split("\n")
    |> parse_lines()
    |> calculate_imcs()
  end

  defp parse_lines(lines) do
    lines
    |> Enum.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
  end

  defp calculate_imcs(parsed_line) do
    parsed_line |> Enum.map(&calculate_imc/1) |> Enum.into(%{})
  end

  defp calculate_imc([name, height, weigth]) do
    {name, weigth / (height * height)}
  end
end
