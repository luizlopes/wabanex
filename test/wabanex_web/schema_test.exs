defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{name: "Banana", email: "banana@test.com", password: "123123"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        query {
          getUser(id: "#{user_id}") {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"getUser" => %{"email" => "banana@test.com", "name" => "Banana"}}
      }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {name:"Testão", email:"teste_testao@teste.com.br", password:"123asd"}) {
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"name" => "Testão", "id" => _id}}} = response
    end
  end
end
