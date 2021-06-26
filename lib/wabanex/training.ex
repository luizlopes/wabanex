defmodule Wabanex.Training do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wabanex.{Exercise, User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:start_date, :end_date, :user_id]

  schema "trainings" do
    field :start_date, :date
    field :end_date, :date

    belongs_to :user, User, type: :binary_id
    has_many :exercises, Exercise

    timestamps()
  end

  # perform casts and validations
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> foreign_key_constraint(:user_id)
    |> validate_required(@fields)
    |> cast_assoc(:exercises)
  end
end
