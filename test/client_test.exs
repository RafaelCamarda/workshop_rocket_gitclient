defmodule Exgit.ClientTest do
  use ExUnit.Case

  import Tesla.Mock

  alias Exgit.Client

  describe "get_repos_by_user/1" do
    test "when the user has repos, returns the repos" do
      username = "rafaelcamarda"

      response = [
        %{"id" => 1234, "name" => "my repo 1", "stargazers_count" => 1},
        %{"id" => 1235, "name" => "my repo 2", "stargazers_count" => 2},
        %{"id" => 1236, "name" => "my repo 3", "stargazers_count" => 3}
      ]

      expected_response = {:ok, response}

      mock(fn
        %{method: :get, url: "https://api.github.com/users/rafaelcamarda/repos"} ->
          %Tesla.Env{status: 200, body: response}
      end)

      assert Client.get_repos_by_user(username) == expected_response
    end

    test "when there is no user with the given name, returns an error" do
      username = "banana"

      expected_response = {:error, "User not found!"}

      mock(fn
        %{method: :get, url: "https://api.github.com/users/banana/repos"} ->
          %Tesla.Env{status: 404, body: ""}
      end)

      assert Client.get_repos_by_user(username) == expected_response
    end

    test "when there is some error, returns the error" do
      username = "rafaelcamarda"

      expected_response = {:error, :timeout}

      mock(fn
        %{method: :get, url: "https://api.github.com/users/rafaelcamarda/repos"} ->
          {:error, :timeout}
      end)

      assert Client.get_repos_by_user(username) == expected_response
    end
  end
end
