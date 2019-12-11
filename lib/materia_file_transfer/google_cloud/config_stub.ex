defmodule MateriaFileTransfer.GoogleCloud.ConfigStub do
  @moduledoc false
  use Goth.Config

  def init(config) do
    {:ok, json} =
      Poison.encode(%{
        project_id: "",
        private_key: ""
      })

    {:ok, Keyword.put(config, :json, json)}
  end
end
