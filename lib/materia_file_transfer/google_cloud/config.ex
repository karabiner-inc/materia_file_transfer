defmodule MateriaFileTransfer.GoogleCloud.Config do
  @moduledoc false
  use Goth.Config

  def init(config) do
    {:ok, Keyword.put(config, :json, System.get_env("GCP_JSON_CREDENTIALS") |> File.read!())}
  end
end
