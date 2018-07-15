defmodule BorkWeb.ClosureChannel do
  use BorkWeb, :channel
  import Ecto.Query
  alias BorkWeb.Presence
  alias Bork.{Repo, User, ClosureParticipant, Closure}
  require IEx
  require Logger

  def join("closure:" <> closure_id, params, socket) do
    socket = assign(socket, :user_bork_id, params["user_bork_id"])
    send(self(), :after_join)
    {:ok, %{channel: "closure:#{ closure_id }"}, assign(socket, :closure_id, closure_id)}
  end

  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)
    user = Repo.get(User, socket.assigns[:user_bork_id])
    closure = Repo.get(Closure, socket.assigns[:closure_id])
    closure_participant = Repo.get_by(ClosureParticipant, user_id: user.id, closure_id: closure.id)
    if !closure_participant do
      Repo.insert!(%ClosureParticipant{user: user, closure: closure})
    end

    {:ok, _} = Presence.track(socket, "user:#{user.id}", %{
      id: user.id,
      name: user.name
    })

    {:noreply, socket}
  end

  def handle_in("closure:finished", params, socket) do
    closure_id = socket.assigns[:closure_id]
    user = Repo.get(User, socket.assigns[:user_bork_id])

    Repo.get_by(ClosureParticipant, user_id: user.id, closure_id: closure_id)
    |> Ecto.Changeset.change(%{ finished: true })
    |> Repo.update!

    total_users_connected = length(Map.keys(Presence.list(socket)))
    users_finished = Repo.one(
      from p in ClosureParticipant, select: count("p.id"), where: p.finished == true and p.closure_id == ^closure_id
    )
    if users_finished >= total_users_connected do
      broadcast!(socket, "closure:done", %{})
    end
    {:reply, :ok, socket}
  end
end
