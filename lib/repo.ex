defmodule Exgit.Repo do
  @keys [:id, :name, :stars]

  @enforce_keys @keys

  defstruct @keys

  def build(%{"id" => id, "name" => name, "stargazers_count" => stars}) do
    %__MODULE__{
      id: id,
      name: name,
      stars: stars
    }
  end
end
