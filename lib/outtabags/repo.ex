defmodule Outtabags.Repo do
  use Ecto.Repo,
    otp_app: :outtabags,
    adapter: Ecto.Adapters.Postgres
end
