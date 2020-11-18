defmodule Exgit.ParserTest do
  use ExUnit.Case

  alias Exgit.{Repos.Parser, Repo}

  describe "build/1" do
    test "when there are repos to parse, returns a list of repos" do
      params = {
        :ok,
        [
          %{"id" => 1234, "name" => "My repo", "stargazers_count" => 5},
          %{"id" => 5678, "name" => "My repo 2", "stargazers_count" => 7}
        ]
      }

      expected_result =
        {:ok,
         [
           %Repo{id: 1234, name: "My repo", stars: 5},
           %Repo{id: 5678, name: "My repo 2", stars: 7}
         ]}

      assert Parser.parse_repos(params) == expected_result
    end

    test "when there is some error, returns the error" do
      params = {:error, "User not found!"}

      assert Parser.parse_repos(params) == params
    end
  end
end
