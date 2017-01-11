defmodule Resume.PdfView do
  use Resume.Web, :view

  def skill_columns(skills) do
    forth = (Enum.count(skills) / 4) |> Float.ceil |> trunc
    {c1,c234} = Enum.split(skills, forth)
    {c2,c34} = Enum.split(c234, forth)
    {c3,c4} = Enum.split(c34, forth)
    {c1,c2,c3,c4}
  end
end
