defmodule Exgit.Repos.Parser do
  alias Exgit.Repo

  def parse_repos({:ok, repos}) when is_list(repos) do
    {:ok, Enum.map(repos, &Repo.build/1)}
  end

  def parse_repos({:error, _reason} = error), do: error
end
