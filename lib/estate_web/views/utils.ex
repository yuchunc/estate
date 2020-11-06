defmodule EstateWeb.ViewUtils do
  def house_types do
    [appartment: "公寓／大廈", studio: "套房", house: "透天", land: "建地"]
  end

  def house_types_for_select do
    house_types() |> Enum.map(fn {k, v} -> {v, k} end)
  end

  def integer_to_curreny(int) do
    int
    |> Integer.to_string()
    |> String.reverse()
    |> Stream.unfold(&String.split_at(&1, 3))
    |> Enum.take_while(&(&1 != ""))
    |> Enum.join(",")
    |> String.reverse()
  end
end
