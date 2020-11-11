defmodule Estate.PreloadData do
  use Agent

  def start_link(_) do
    {:ok, pid} = Registry.start_link(keys: :unique, name: __MODULE__)

    counties =
      raw_counties()
      |> Enum.map(& &1["CityName"])
      |> List.delete("釣魚臺")
      |> List.delete("南海島")

    Registry.register(__MODULE__, :raw_counties, raw_counties())
    Registry.register(__MODULE__, :counties, counties)

    Registry.register(
      __MODULE__,
      :counties_with_districs,
      Enum.map(counties, &{&1, get_districs(&1)})
    )

    {:ok, pid}
  end

  def counties do
    [{_, counties}] = Registry.lookup(__MODULE__, :counties)

    counties
  end

  def counties_with_districs do
    [{_, res}] = Registry.lookup(__MODULE__, :counties_with_districs)

    res
  end

  defp raw_counties do
    "priv/taiwan_counties.json"
    |> File.read!()
    |> Jason.decode!()
  end

  defp get_districs(county) do
    raw_counties()
    |> Enum.find(&(&1["CityName"] == county))
    |> Map.get("AreaList")
    |> Enum.map(& &1["AreaName"])
  end
end
