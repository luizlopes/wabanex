defmodule Wabanex.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :password, :string

      # add columns 'inserted_at' and 'updated_at'
      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
