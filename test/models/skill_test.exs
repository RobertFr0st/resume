defmodule Resume.SkillTest do
  use Resume.ModelCase

  alias Resume.Skill

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}
  @invalid_short_name %{name: ""}
  @invalid_long_name %{name: "................."}

  test "changeset with valid attributes" do
    changeset = Skill.changeset(%Skill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Skill.changeset(%Skill{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with invalid short name" do
    changeset = Skill.changeset(%Skill{}, @invalid_short_name)
    refute changeset.valid?
  end

  test "changeset with invalid long name" do
    changeset = Skill.changeset(%Skill{}, @invalid_long_name)
    refute changeset.valid?
  end
end
