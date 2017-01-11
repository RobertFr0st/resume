defmodule Resume.PdfViewTest do
  use Resume.ConnCase, async: true

  @even_list [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]

  test "twice an even size list produces equal size columns" do
    {a,b,c,d} = Resume.PdfView.skill_columns(@even_list)
    assert length(a) == length(b) && length(c) == length(d) && length(a) == length(c)
  end
end
