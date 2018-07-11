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
    broadcast!(socket, "closure:#{ closure_id }:who_finished", %{})
    {:reply, :ok, socket}
  end
end


# idea de como fazer
# criar tabela usuario_fechamento
# uuid closure_id finished = default = false
#
# usuario deu join no channel, insere linha na tabela
#
# usuario deu finished
#   marca que naquele usuario_fechamento ele esta finished
#   verifica se todos estao finished, se sim da broadcast para mudar tela
