defmodule Exgit.RepoTest do
  use ExUnit.Case

  alias Exgit.Repo

  describe "build/1" do
    test "returns a repo struct" do
      params = %{"id" => 1234, "name" => "My repo", "stargazers_count" => 5}

      expected_result = %Repo{id: 1234, name: "My repo", stars: 5}

      assert Repo.build(params) == expected_result
    end
  end
end
