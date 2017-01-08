defmodule Resume.PdfController do
  use Resume.Web, :controller

  def export(conn, _) do
    {:ok, pdf} = render_to_string(Resume.PdfView, :resume, name: "resume")
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
