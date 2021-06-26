defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Banana", email: "banana@test.com", password: "321321"}

      response = User.changeset(params)

      assert %Ecto.Changeset{valid?: true, errors: [], changes: ^params} = response
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "x", email: "banana@test.com"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
