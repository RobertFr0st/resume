defmodule Resume.ResumeTest do
  use Resume.ModelCase

  alias Resume.Resume

  @valid_attrs %{file_name: "some content", objective: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Resume.changeset(%Resume{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Resume.changeset(%Resume{}, @invalid_attrs)
    refute changeset.valid?
  end
end
