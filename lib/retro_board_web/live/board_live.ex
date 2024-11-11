defmodule RetroBoardWeb.BoardLive do
  use RetroBoardWeb, :live_view
  alias RetroBoard.Boards

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:boards, Boards.list_boards())
     |> assign(:pahe_title, "Boards")}
  end
end
