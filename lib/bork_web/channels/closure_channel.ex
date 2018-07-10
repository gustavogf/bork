defmodule BorkWeb.ClosureChannel do
  use BorkWeb, :channel
  require Logger

  def join("closure:" <> closure_id, params, socket) do
    users = socket.assigns[:users] || %{}
    users = Map.merge(users, %{ params["user_id"] => %{ finished: false } })
    socket = assign(socket, :users, users)
    {:ok, %{channel: "closure:#{ closure_id }"}, assign(socket, :closure_id, closure_id)}
  end

  def handle_in("closure:finished", params, socket) do
    closure_id = socket.assigns[:closure_id]
    #user_id = params["user_id"]
    #users = socket.assigns[:users]
    #users[user_id][:finished] = true
    #socket = assign(socket, :users, users)

    broadcast!(socket, "closure:#{ closure_id }:who_finished", %{})
    {:reply, :ok, socket}
  end
end
