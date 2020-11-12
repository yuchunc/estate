defmodule Estate.LVRDatum.Importer do
  alias NimbleCSV.RFC4180, as: CSV
  alias Estate.LVRDatum
  alias Estate.Repo

  @data_dir System.get_env("LVR_ROOT")
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
    :has_management,
    :transaction_ntd_amount,
    :ntd_per_square_meter,
    :parking_type,
    :parking_area,
    :parking_ntd_amount,
    :note,
    :serial
  ]
  @county_code %{
    "a" => "臺北市",
    "b" => "臺中市",
    "c" => "基隆市",
    "d" => "臺南市",
    "e" => "高雄市",
    "f" => "新北市",
    "g" => "宜蘭縣",
    "h" => "桃園市",
    "i" => "嘉義市",
    "j" => "新竹縣",
    "k" => "苗栗縣",
    "m" => "南投縣",
    "n" => "彰化縣",
    "o" => "新竹市",
    "p" => "雲林縣",
    "q" => "嘉義縣",
    "t" => "屏東縣",
    "u" => "花蓮縣",
    "v" => "臺東縣",
    "w" => "金門縣",
    "x" => "澎湖縣",
    "z" => "連江縣"
  }

  def run do
    File.ls!(@data_dir)
    |> List.delete(".DS_Store")
    |> Stream.map(&traverse_folder/1)
    |> Stream.run()
  end

  defp traverse_folder(dir) do
    File.ls!(@data_dir <> "/" <> dir)
    |> Stream.filter(&String.match?(&1, ~r/[a-z]_lvr_land_[a-d].csv/))
    |> Stream.map(&(Enum.join([@data_dir, dir, &1], "/") |> parse_csv))
    |> Stream.run()
  end

  def parse_csv(filename) do
    county =
      filename
      |> String.split("/")
      |> List.last()
      |> get_county()

    filename
    |> File.stream!()
    |> CSV.parse_stream()
    |> Stream.map(&formatter(&1, county))
    |> Stream.each(&store/1)
    |> Stream.run()
  end

  defp formatter(row, county) do
    if row |> List.first() |> String.starts_with?(@alphabats) do
      :skip
    else
      attrs =
        [@columns, row]
        |> List.zip()
        |> Enum.into(%{})
        |> isolate_embeds()
        |> scrap_data()

      LVRDatum.changeset(%LVRDatum{county: county}, attrs)
    end
  end

  defp store(:skip), do: :ok

  defp store(data) do
    Repo.insert(data)
  end

  defp get_county(filename) do
    <<code::binary-size(1)>> <> _ = filename

    @county_code[code]
  end

  defp isolate_embeds(attrs) do
    {bplan_attrs, attrs1} = Map.split(attrs, [:bedrooms, :halls, :bathrooms, :compartment])

    attrs1
    |> Map.get_and_update!(:transaction_itinary, fn tran_itin ->
      [land, building, parking] =
        Regex.scan(~r/\d+/, tran_itin)
        |> List.flatten()

      {tran_itin, %{land_count: land, building_count: building, parking_count: parking}}
    end)
    |> elem(1)
    |> Map.put(:building_plan, bplan_attrs)
  end

  defp scrap_data(attrs) do
    has_management = Map.get(attrs, :has_management)
    transaction_date = Map.get(attrs, :transaction_date)
    building_complete_date = Map.get(attrs, :building_complete_date)
    district = Map.get(attrs, :district)
    approximate_address = Map.get(attrs, :approximate_address)

    patch = %{
      has_management: has_management == "有",
      transaction_date: convert_date(transaction_date),
      building_complete_date: convert_date(building_complete_date),
      district: tai_converter(district),
      approximate_address: tai_converter(approximate_address)
    }

    Map.merge(attrs, patch)
  end

  defp convert_date(""), do: nil

  defp convert_date(era_date) do
    <<yyy::binary-size(3)>> <> <<mm::binary-size(2)>> <> <<dd::binary-size(2)>> =
      era_date |> String.pad_leading(7, "0")

    year =
      yyy
      |> String.to_integer()
      |> Kernel.+(1911)

    case Date.from_iso8601("#{year}-#{mm}-#{dd}") do
      {:ok, dt} -> dt
      _ -> nil
    end
  end

  defp tai_converter(nil), do: nil

  defp tai_converter(string) do
    String.replace(string, "台", "臺")
  end
end
