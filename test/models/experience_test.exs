defmodule Resume.ExperienceTest do
  use Resume.ModelCase

  alias Resume.Experience

  @valid_attrs %{category: "Work", from: %{day: 17, month: 4, year: 2010}, organization: "some content", position: "some content", to: %{day: 17, month: 4, year: 2010}}

  @valid_category %{category: "Work", from: %{day: 17, month: 4, year: 2010}, organization: "some content", position: "some content", to: %{day: 17, month: 4, year: 2010}}


  @invalid_dates %{category: "test", from: %{day: 17, month: 4, year: 2011}, organization: "some content", position: "some content", to: %{day: 17, month: 4, year: 2010}}

  @invalid_category %{category: "test", from: %{day: 17, month: 4, year: 2010}, organization: "some content", position: "some content", to: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Experience.changeset(%Experience{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Experience.changeset(%Experience{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "valid catagory passed, Work" do
    changeset = Experience.changeset(%Experience{}, @valid_category)
    assert changeset.valid?
  end

  test "invalid catagory passed, test" do
    changeset = Experience.changeset(%Experience{}, @invalid_category)
    refute changeset.valid?
  end

  test "invalid to date past, is in the future" do
    changeset = Experience.changeset(%Experience{}, @invalid_dates)
    refute changeset.valid?
  end
end
