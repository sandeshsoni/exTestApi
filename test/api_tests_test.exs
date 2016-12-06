defmodule ApiTestsTest do
  use ExUnit.Case
  # doctest ApiTests

  defp host(port) do
    "http://localhost:#{port}/api"
  end

  defp host do
    host(4000)
  end

  test "questions index" do
    path = "questions"
    url = "#{ host }/#{ path }"
    {:ok, response} = HTTPoison.get(url)
    %{:status_code => status_code, :body => body} = response
    assert status_code == 200
  end

  test "try to create a record with incomplete params should give validation errors" do
    path = "questions"
    url = "#{ host }/#{ path }"
    hash = %{"question" => %{"title": "hello"}}
    {:ok, resp } = Poison.encode hash

    headers = %{ "Content-Type": "application/json" }
    {:ok, response} = HTTPoison.post(url, resp, headers)
    %{:status_code => status_code, body: body} = response
    {:ok, decoded} = Poison.decode(body)
    assert status_code == 422

  end


  test "create new record and show it" do
    path = "questions"
    url = "#{ host }/#{ path }"
    hash = %{"question" => %{"title": "hello", "difficulty": 5, "topic": "demo"}}
    {:ok, resp } = Poison.encode hash

    headers = %{ "Content-Type": "application/json" }
    {:ok, response} = HTTPoison.post(url, resp, headers)
    %{:status_code => status_code, body: body} = response
    {:ok, decoded} = Poison.decode(body)
    assert status_code == 201
  end

  test "create, show and delete record" do

    path = "questions"
    url = "#{ host }/#{ path }"
    hash = %{"question" => %{"title": "hello", "difficulty": 5, "topic": "demo"}}
    {:ok, resp } = Poison.encode hash

    headers = %{ "Content-Type": "application/json" }
    {:ok, response} = HTTPoison.post(url, resp, headers)
    %{:status_code => status_code, body: body} = response
    {:ok, decoded} = Poison.decode(body)
    assert status_code == 201
    %{"id" => new_record_id} = decoded["data"]

    # show record
    path = "questions/#{new_record_id}"
    url = "#{ host }/#{ path }"

    {:ok, response} = HTTPoison.get(url)
    %{:status_code => status_code, :body => body} = response
    assert status_code == 200

    {:ok, response} = HTTPoison.delete("#{url}")
    %{:status_code => status_code, body: body} = response
    assert status_code == 204
  end

  test "create new record, show, edit and update, verify and delete record" do
    hash = %{
      "question": %{
        "title": "foo",
        "difficulty": 1,
        "topic": "none"
      }
    }

    {:ok, encoded_hash} = Poison.encode(hash)

    headers = %{"Content-Type" => "application/json"}

    #POST
    # create record
    {:ok, create_record_response} = HTTPoison.post("#{host}/questions", encoded_hash, headers)
    %{status_code: status_code, body: body} = create_record_response
    assert status_code == 201
    # record was created

    {:ok, %{"data" => data} = response_recieved} = Poison.decode(body)
    %{"id" => record_id, "title" => title } = data

    # new_hash = Map.take(response_recieved, ["topic", "difficulty"])
    # {:ok, new_hash_encoded} = Poison.encode(Map.merge(new_hash, %{"title" => "bar"}))


    #GET


    #PATCH

    new_title = "bar"
    url = "#{host}/questions/#{record_id}"
    {:ok, new_hash} = Poison.encode(%{"question" => %{"title" => new_title} })
    {:ok, update_record_response} = HTTPoison.patch(url, new_hash, headers )

    %{status_code: status_code, body: body} = update_record_response
    assert status_code == 200
    {:ok, decoded_body} = Poison.decode(body)

    assert decoded_body["data"]["title"] == new_title

  end

end
