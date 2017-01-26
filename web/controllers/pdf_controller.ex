defmodule Resume.PdfController do
  use Resume.Web, :controller

  alias Resume.Coherence.RegistrationController, as: User

  def export(conn, _) do

    user = Coherence.current_user(conn) |> User.preload_resume

    pdf = Phoenix.View.render_to_string(Resume.PdfView, "pdf.html", user: user)
      |> PdfGenerator.generate_binary!

    download(conn, pdf)
  end

  def new(conn, _) do 
    #if I choose to have a resume model will make export much simpler to impliment
    #changeset = Resume.changeset(%Resume{})
    render(conn, "new.html")#, changeset: changeset)
  end

  defp download(conn, pdf) do
    conn
    |> put_resp_content_type("text/pdf")
    |> put_resp_header("content-disposition", "attachment; filename=\"resume.pdf\"")
    |> send_resp(200, pdf)
  end
end
