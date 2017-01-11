defmodule Resume.ExperienceTest do
  use Resume.ModelCase

  alias Resume.Experience

  @valid_attrs %{category: "some content", from: %{day: 17, month: 4, year: 2010}, organization: "some content", position: "some content", to: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Experience.changeset(%Experience{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Experience.changeset(%Experience{}, @invalid_attrs)
    refute changeset.valid?
  end
end
