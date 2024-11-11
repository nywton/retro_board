defmodule RetroBoard.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :body, :text
      add :type, :string
      add :user, :string
      add :board_id, references(:boards, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:cards, [:board_id])
  end
end
