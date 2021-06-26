defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  describe "calculate/1" do
    test "when file exists, return the data" do
      params = %{"filename" => "students.csv"}

      response = Wabanex.IMC.calculate(params)

      expected_response =
        {:ok,
         %{
           "Benicio" => 15.468749999999998,
           "Luana" => 21.872422819032593,
           "Luiz" => 21.79930795847751
         }}

      assert response == expected_response
    end

    test "when file doesnt exists, return error message" do
      params = %{"filename" => "wrong.csv"}

      response = Wabanex.IMC.calculate(params)

      expected_response = {:error, "error while opening file"}

      assert response == expected_response
    end
  end
end
