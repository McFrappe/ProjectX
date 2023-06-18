defmodule Lopptor.Repo do
  use Ecto.Repo,
    otp_app: :lopptor,
    adapter: Ecto.Adapters.Postgres
end
