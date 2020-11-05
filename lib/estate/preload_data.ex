defmodule Estate.PreloadData do
  use Agent

  def start_link(_) do
    {:ok, pid} = Registry.start_link(keys: :unique, name: __MODULE__)

    raw_counties =
      "priv/taiwan_counties.json"
      |> File.read!()
      |> Jason.decode!()

    counties =
      Enum.map(raw_counties, &%{eng_county_name: &1["CityEngName"], county_name: &1["CityName"]})

    Registry.register(__MODULE__, :raw_counties, raw_counties)
    Registry.register(__MODULE__, :counties, counties)

    {:ok, pid}
  end

  def counties do
    [{_, counties}] = Registry.lookup(__MODULE__, :counties)
    counties |> Enum.map(& &1[:county_name])
  end

  def house_types do
    [ "公寓／大廈": "appartment",
    "套房": "studio",
    "透天": "house",
    "建地": "land"
    ]
  end
end
