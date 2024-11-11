defmodule RetroBoardWeb.BoardLive do
  use RetroBoardWeb, :live_view
  alias RetroBoard.Boards
  alias RetroBoard.Boards.Board

  @impl true
  def mount(_params, _session, socket) do
    new_board = %Board{}
    chnageset = Boards.change_board(new_board)

    {:ok,
     socket
     |> assign(:boards, Boards.list_boards())
     |> assign(:pahe_title, "Boards")
     |> assign(:board, new_board)
     |> assign(:changeset, chnageset)
     |> assign(:valid, false)}
  end

  @impl true
  def handle_event("validate", %{"board" => board_params}, socket) do
    changeset =
      socket.assigns.board
      |> Boards.change_board(board_params)
      |> Map.put(:action, :validade)

    IO.inspect(changeset)

    {:noreply,
     socket
     |> assign(:valid, changeset.valid?)
     |> assign(:changeset, changeset)}
  end

  def handle_event("save", %{"board" => board_params}, socket) do
    if socket.assigns.valid do
      case Boards.create_board(board_params) do
        {:ok, board} ->
          {:noreply,
           socket
           |> assign(:boards, [board | socket.assigns.boards])
           |> assign(:valid, false)
           |> put_flash(:info, "Board created successfully")}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, :changeset, changeset)}
      end
    else
      {:noreply, socket}
    end
  end

  defp button_valid(true), do: "bg-indigo-600 hover:bg-indigo-700"
  defp button_valid(false), do: "bg-zinc-600"
end
