defmodule Resume.SkillTest do
  use Resume.ModelCase

  alias Resume.Skill

  @valid_attrs %{category: "some content", description: "some content", end_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, name: "some content", start_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Skill.changeset(%Skill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Skill.changeset(%Skill{}, @invalid_attrs)
    refute changeset.valid?
  end
end
