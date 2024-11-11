defmodule RetroBoard.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset
  alias RetroBoard.Cards.Card

  schema "boards" do
    field :title, :string

    has_many :start_cards, Card, where: [type: "start"]
    has_many :stop_cards, Card, where: [type: "stop"]
    has_many :continue_cards, Card, where: [type: "continue"]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
