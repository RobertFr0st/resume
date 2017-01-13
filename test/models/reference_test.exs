defmodule Resume.ReferenceTest do
  use Resume.ModelCase

  alias Resume.Reference

  @valid_attrs %{association: "some content", email: "some content", name: "some content", phone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Reference.changeset(%Reference{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Reference.changeset(%Reference{}, @invalid_attrs)
    refute changeset.valid?
  end
end
