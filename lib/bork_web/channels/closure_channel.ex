defmodule BorkWeb.ClosureChannel do
  use BorkWeb, :channel
  alias BorkWeb.Presence
  alias Bork.{Repo, User}
  require IEx
  require Logger

  def join("closure:" <> closure_id, params, socket) do
    socket = assign(socket, :user_bork_id, params["user_bork_id"])
    send(self(), :after_join)
    {:ok, %{channel: "closure:#{ closure_id }"}, assign(socket, :closure_id, closure_id)}
  end

  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)
    user = Repo.get!(User, socket.assigns[:user_bork_id])

    {:ok, _} = Presence.track(socket, "user:#{user.id}", %{
      id: user.id,
      name: user.name,
      finished: false
    })

    {:noreply, socket}
  end

  def handle_in("closure:finished", params, socket) do
    closure_id = socket.assigns[:closure_id]
    user = Repo.get!(User, socket.assigns[:user_bork_id])
    Presence.update(socket, "user:#{user.id}", %{
      id: user.id,
      name: user.name,
      finished: true
    })
    # total_users_connected = length(Map.keys(Presence.list(socket)))
    # finished_users = 0
    # Enum.each Presence.list(socket), fn {k, v} ->
    #   if v[:metas][0]["finished"]
    # end
    # broadcast!(socket, "closure:#{ closure_id }:done", %{})
    {:reply, :ok, socket}
  end
end
