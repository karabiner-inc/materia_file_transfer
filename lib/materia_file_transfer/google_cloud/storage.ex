defmodule MateriaFileTransfer.GoogleCloud.Storage do
  @moduledoc false
  alias MateriaUtils.String.StringUtil
  alias Materia.Errors.BusinessError

  @doc false
  def upload_file_private(params) do
    params
    |> check_file_params()
    |> upload([{:predefinedAcl, "private"}])
  end

  @doc false
  def upload_file_public(params) do
    params
    |> check_file_params()
    |> upload([{:predefinedAcl, "publicread"}])
  end

  @doc false
  defp check_file_params(params) do
    if StringUtil.is_empty(params["file"]) do
      raise BusinessError, message: "file not found."
    else
      params
    end
  end

  @doc false
  defp get_connection() do
    {:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/cloud-platform")
    GoogleApi.Storage.V1.Connection.new(token.token)
  end

  @doc false
  defp upload(params, optional_params) do
    file = params["file"]
    directory_name = params["directory"]
    file_name =
      if StringUtil.is_empty(directory_name) do
        "#{UUID.uuid4()}/#{file.filename}"
      else
        "#{directory_name}/#{UUID.uuid4()}/#{file.filename}"
      end
    {:ok, object} = GoogleApi.Storage.V1.Api.Objects.storage_objects_insert_simple(
      get_connection(),
      get_bucket_id(),
      "multipart",
      %{name: file_name, contentType: file.content_type},
      file.path,
      optional_params
    )
    object
  end

  @doc false
  defp get_bucket_id() do
    bucket_id = Application.get_env(:materia, :bucket_id)
    if StringUtil.is_empty(bucket_id) do
      raise BusinessError, message: "bucket_id not found."
    else
      bucket_id
    end
  end

  @doc false
  def download(storage_path, file_path) do
    {:ok, tesla} = GoogleApi.Storage.V1.Api.Objects.storage_objects_get(
      get_connection(),
      get_bucket_id(),
      storage_path,
      [{:alt, "media"}],
      [{:decode, false}]
    )
    :ok = File.write!(file_path, tesla.body)
  end
end
