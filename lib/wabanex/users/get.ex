defmodule Wabanex.Users.Get do
  import Ecto.Query

  alias Ecto.UUID
  alias Wabanex.{Repo, Training, User}

  def call(id) do
    id
    |> UUID.cast()
    |> handle_result
  end

  defp handle_result(:error) do
    {:error, "Invalid UUID"}
  end

  defp handle_result({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil ->
        {:error, "User not found"}

      user ->
        {:ok, load_training(user)}
        # user -> {:ok, (Wabanex.Repo.preload user, [training: [:exercises]]) }
    end
  end

  defp load_training(user) do
    today = Date.utc_today()

    query = from t in Training, where: ^today >= t.start_date and ^today <= t.end_date

    Repo.preload(user, trainings: {first(query, :inserted_at), :exercises})
  end
end
