defmodule Resume.PdfController do
  use Resume.Web, :controller

  alias Resume.Repo

  def export(conn, _) do

    user = Coherence.current_user(conn) |> Repo.preload([:skills])

    pdf = Phoenix.View.render_to_string(Resume.PdfView, "pdf.html", user: user)
      |> PdfGenerator.generate_binary!

    download(conn, pdf)
  end

  defp download(conn, pdf) do
    conn
    |> put_resp_content_type("text/pdf")
    |> put_resp_header("content-disposition", "attachment; filename=\"resume.pdf\"")
    |> send_resp(200, pdf)
  end
end
