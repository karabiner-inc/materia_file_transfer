defmodule MateriaFileTransferWeb.GoogleCloudView do
  use MateriaFileTransferWeb, :view

  def render("googleCloudStorage.json", %{upload: upload}) do
    %{
      name: upload.name,
      content_type: upload.contentType,
      url: "https://storage.googleapis.com/#{upload.bucket}/#{upload.name}"
    }
  end
end
