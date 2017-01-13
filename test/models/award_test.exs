defmodule Resume.AwardTest do
  use Resume.ModelCase

  alias Resume.Award

  @valid_attrs %{on: %{day: 17, month: 4, year: 2010}, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Award.changeset(%Award{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Award.changeset(%Award{}, @invalid_attrs)
    refute changeset.valid?
  end
end
