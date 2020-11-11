defmodule Estate.LVRDatum.Import do
  alias NimbleCSV.RFC4180, as: CSV
  alias Estate.LVRDatum

  @data_dir "/Users/mickey/Desktop/lvr_data"
  @alphabats for n <- ?A..?z, do: <<n::utf8>>
  @columns [
    :district,
    :subject_type,
    :approximate_address,
    :transaction_building_area,
    :city_zone,
    :urban_zone,
    :urban_usage,
    :transaction_date,
    :transaction_itinary,
    :transaction_floor,
    :total_floor,
    :building_type,
    :main_usage,
    :building_main_material,
    :building_complete_date,
    :transaction_land_area,
    :bedrooms,
    :halls,
    :bathrooms,
    :compartment,
    :transaction_ntd_amount,
    :ntd_per_square_meter,
    :parking_type,
    :parking_area,
    :parking_ntd_amount,
    :note,
    :serial
  ]
  @county_code %{
    a: "臺北市",
    b: "臺中市",
    c: "基隆市",
    d: "臺南市",
    e: "高雄市",
    f: "新北市",
    g: "宜蘭縣",
    h: "桃園市",
    i: "嘉義市",
    j: "新竹縣",
    k: "苗栗縣",
    m: "南投縣",
    n: "彰化縣",
    o: "新竹市",
    p: "雲林縣",
    q: "嘉義縣",
    t: "屏東縣",
    u: "花蓮縣",
    v: "臺東縣",
    w: "金門縣",
    x: "澎湖縣",
    z: "連江縣"
  }

  def run do
    File.ls!(@data_dir)
    |> Stream.map(&traverse_folder/1)
  end

  def traverse_folder(dir) do
    File.ls!(@data_dir <> "/" <> dir)
    |> Stream.filter(&String.match?(&1, ~r/[a-z]_lvr_land_[a-d].csv/))
    |> Stream.map(&(List.join([@data_dir, dir, &1], "/") |> parse_csv))
  end

  def parse_csv(filename) do
    county = get_county(filename)

    filename
    |> File.stream!()
    |> CSV.parse_stream()
    |> Stream.map(&formatter(&1, county))
    |> Stream.each(&store/1)
  end

  defp formatter(row, county) do
    if row |> List.first() |> String.starts_with?(@alphabats) do
      :skip
    else
      [@columns, row]
      |> List.zip
      |> Enum.into(%{})
      |> IO.inspect(label: "map")
    end
  end

  defp store(:skip), do: :ok

  defp store(data) do
    #data |> IO.inspect(label: "data")
  end

  defp get_county(district) do
  end

  defp counties_with_districts do
    Estate.PreloadData.counties_with_districts()
  end

  defp tai_converter(string) do
    String.replace(string, "台", "臺")
  end
end
