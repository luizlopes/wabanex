defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  alias Wabanex.IMC

  def index(conn, params) do
    params
    |> IMC.calculate()
    |> handle_response(conn)
  end

  defp handle_response({:ok, data}, conn), do: render_response(conn, data, :ok)

  defp handle_response({:error, error}, conn), do: render_response(conn, error, :bad_request)

  defp render_response(conn, result, status) do
    conn
    |> put_status(status)
    |> json(result)
  end
end
