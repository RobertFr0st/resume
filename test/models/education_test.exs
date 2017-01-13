defmodule Resume.EducationTest do
  use Resume.ModelCase

  alias Resume.Education

  @valid_attrs %{degree: "some content", from: %{day: 17, month: 4, year: 2010}, gpa: "120.5", organization: "some content", status: "some content", to: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Education.changeset(%Education{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Education.changeset(%Education{}, @invalid_attrs)
    refute changeset.valid?
  end
end
