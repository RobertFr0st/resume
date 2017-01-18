defmodule Resume.PdfView do
  use Resume.Web, :view

  @months ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

  def skill_columns(skills) do
    forth = (Enum.count(skills) / 4) |> Float.ceil |> trunc
    {c1,c234} = Enum.split(skills, forth)
    {c2,c34} = Enum.split(c234, forth)
    {c3,c4} = Enum.split(c34, forth)
    {c1,c2,c3,c4}
  end

  def experience_rows(experiences) do
    work = Enum.filter(experiences, &(&1.category == "Work"))
    volunteer = Enum.filter(experiences, &(&1.category == "Volunteer"))
    project = Enum.filter(experiences, &(&1.category == "Project"))
    {work, volunteer, project}
  end

  def english_date(date) do
    [_, year, month] = Regex.run(~r/^(\d{4})-(\d{1,2})/, to_string(date))
    index = String.to_integer(month) - 1
    "#{Enum.at(@months, index)} #{year}"
  end

  @doc """
    No support for international code as of yet.
    Default format is (xxx) xxx-xxxx
  """
  def phone_format(phone) do
    if(phone) do
      [_, area_code, three_set, four_set] = Regex.run(~r/\(?(\d{3})\)?[-| ]*(\d{3})[-| ]*(\d{4})/, phone)
      "(#{area_code}) #{three_set}-#{four_set}"
    else
     ""
    end
  end
end
