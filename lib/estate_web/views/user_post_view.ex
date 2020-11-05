defmodule EstateWeb.UserPostView do
  use EstateWeb, :view

  alias Estate.PreloadData
  alias Estate.Utils

  @option_translation %{
    has_parking: "含車位",
    has_elevator: "有電梯"
  }

  def options_badge_text(%{__struct__: _} = opts) do
    opts
    |> Map.from_struct
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
