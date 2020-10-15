defmodule EstateWeb.UserRegistrationController do
  use EstateWeb, :controller

  alias Estate.Account
  alias Estate.Account.User
  alias EstateWeb.UserAuth

  def new(conn, _params) do
    changeset = Account.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Account.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Account.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :confirm, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
