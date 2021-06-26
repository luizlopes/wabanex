defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, then return IMC info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "Benicio" => 15.468749999999998,
        "Luana" => 21.872422819032593,
        "Luiz" => 21.79930795847751
      }

      assert response == expected_response
    end

    test "when there are invalid params, then return an error", %{conn: conn} do
      params = %{"filename" => "wrong.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = "error while opening file"

      assert response == expected_response
    end
  end
end
