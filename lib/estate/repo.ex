defmodule Estate.Repo do
  use Ecto.Repo,
    otp_app: :estate,
    adapter: Ecto.Adapters.Postgres
end
