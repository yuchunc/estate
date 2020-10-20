defmodule Estate.Account.Profile do
  use Estate, :schema

  embedded_schema do
    field :phone_number, :string
  end
end
