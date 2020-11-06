defmodule EstateWeb.ViewUtils do
  @option_translation %{
    has_parking: "含車位",
    has_elevator: "有電梯"
  }

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

  def options_badge_text(%{__struct__: _} = opts) do
    opts
    |> Map.from_struct()
    |> options_badge_text()
  end

  def options_badge_text(opts) do
    Enum.flat_map(opts, fn
      {opt, true} -> [opt]
      _ -> []
    end)
  end

  def translate_option(opt) do
    @option_translation[opt]
  end
end
