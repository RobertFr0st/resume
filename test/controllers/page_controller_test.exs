defmodule Resume.PageControllerTest do
  use Resume.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "ResuGen"
  end
end
