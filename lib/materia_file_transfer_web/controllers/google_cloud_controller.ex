defmodule MateriaFileTransferWeb.GoogleCloudController do
  use MateriaFileTransferWeb, :controller

  alias MateriaFileTransfer.GoogleCloud.Storage

  action_fallback MateriaWeb.FallbackController

  def upload_file_public(conn, params) do
    upload = Storage.upload_file_public(params)
    render(conn, "googleCloudStorage.json", upload: upload)
  end

  def upload_file_private(conn, params) do
    upload = Storage.upload_file_private(params)
    render(conn, "googleCloudStorage.json", upload: upload)
  end
end
