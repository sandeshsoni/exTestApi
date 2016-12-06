defmodule UsersApiTest do
  # use ExUnit.Case
  # use ApiTests, %{ host: "http://api.amzn.com/", params: %{aff: AMN_ID}}
  use ApiTests, %{path: "/questions", host: "http://localhost:4000/api"}
  # use ApiTests
  # doctest UsersApi

  # test_api "amazon offers", %{host: "http://api.amazon.com/v2/", aff_id: 1234} do

  #   assert_status_code get "offers" == 200
  #   assert_status_code get "cat/mobiles" == 200
  #   assert_status_code get "offers/lightining" == 200
  #   assert_status_code get "deal_of_day" == 200

  # end

  test_create "" do
    # with valid_params
  end

  test "CRUD with invalid params" do

    invalid_params
    |> make_create_request
    |> test

    valid_params
    |> create
    |> test_status
    |> show
    |> delete
  end

  test "CRUD with valid params" do
    #
  end

  test_crud "crud crud" do
    valid_params = %{}
    invalid_params = %{}

    # create invalid
    # response = create_valid
    # show(id)
    # update(valid)
    # deleted
    # show deleted
  end

  test_api "costco"
  test_api "target"
  test_api "groupon"
  test_api "best_buy"
  test_api "overstock"

  # test_crud_api "something" do
  #   # Index, create, show, index, delete, index
  # end

  test_api "questions CRUD on questions", %{host: "localhost"} do
    # assert_response index get %{}
    # assert_response show get %{}

    # assert_status_code get "1" == 200
    assert_status_code get "/questions" == 200
    assert_response get "/questions" == %{"data" => []}

    assert_status_code get "/questions/1" == 404
    assert_status_code get "/questions/5" == 200
    # assert_status_code get {"/questions/5", %{}} == 200
    # assert_status_code post "/", %{} = 201

    # assert_response get "id" == %{:data => %{"foo": "bar"}}
    # assert_response get "/offers" == %{:data => %{"foofer" => "boffer"}}

    # assert_response post "/users", hash == %{:data => %{"foo" => "bar"}}
    # assert_response get index == %{:data => %{}}
  end


end
