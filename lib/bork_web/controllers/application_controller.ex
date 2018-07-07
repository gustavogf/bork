defmodule BorkWeb.ApplicationController do
  use BorkWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
