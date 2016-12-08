defmodule UsersApiTest do
  # use ExUnit.Case

  use ApiTests, %{ host: "http://localhost/",
                   port: 4000,
                   params: %{aff: AMN_ID},
                   endpoint: "/api"
  }

  # test_api "amazon offers", %{host: "http://api.amazon.com/v2/", aff_id: 1234} do
  #   assert_status_code get "offers" == 200
  #   assert_status_code get "cat/mobiles" == 200
  #   assert_status_code get "offers/lightining" == 200
  #   assert_status_code get "deal_of_day" == 200
  # end

  # setup do
  #   {:ok,
  #    [valid_params: %{
  #      title: "some title random_number"
  #    },
  #     invalid_params: %{
  #       link: ""
  #     }
  #     ]
  #   }
  # end

  # def setup_all do
  #   invalid_params = %{
  #     title: ""
  #   }
  # end

  # index
  # sorted index
  # filtered index
  test_url "index with blank data" do
    response = get "/"
    assert_status_code response  == 200
    assert_keys_present response  == [:data]
    assert_keys_present response[:data]  == [:first_name]

    json_structure = %{}
    assert_match response == structure
  end

  test_url "/delete" do
    #
  end

  test_url "create and delete", %{valid_params: ""} do

    # response = post "/", context[:valid_params]
    response = post "/", valid_params
    assert_status_code response.status_code == 200
    assert_response response.response == %{
      "data": []
    }

    # assert_here json
    # make sure response is in given format.
    # test_that_json
    %{"data" => %{"id" => id }} = response

    response = get "id"
    assert_status_code response.status_code == 200
    assert_response response.response == %{
      "data": []
    }

    response = delete "id"
    assert_status_code response.status_code == 200

  end

  test_url "when title is missing" do
    post valid_params - :title
    |> assert_response = %{
      "data" => %{}
    }
  end

  test_url "with topic from params missing" do
    post valid_params - :topic
  end

  test_url "with topic and title from params missing" do
    post valid_params - [:topic, :title]
  end

  test_url "create and show" do
    response = post "/", valid_attributes
    assert_status_code response.status_code == 200
    assert_response response.response == %{
      "data": []
    }

  end

  test_url "CRUD with invalid params" do

    # invalid_params
    # |> make_create_request
    # |> test

    # valid_params
    # |> create
    # |> test_status
    # |> show
    # |> delete

  end

  # test "CRUD with valid params" do
  #   #
  # end

  # test_crud "crud crud" do
  #   valid_params = %{}
  #   invalid_params = %{}

  #   # create invalid
  #   # response = create_valid
  #   # show(id)
  #   # update(valid)
  #   # deleted
  #   # show deleted
  # end

  # test_api "costco"
  # test_api "target"
  # test_api "groupon"
  # test_api "best_buy"
  # test_api "overstock"

  # test_crud_api "something" do
  #   # Index, create, show, index, delete, index
  # end

  test_url "questions CRUD on questions" do
    # assert_response index get %{}
    # assert_response show get %{}

    # # assert_status_code get "1" == 200
    # assert_status_code get "/questions" == 200
    # assert_response get "/questions" == %{"data" => []}

    # assert_status_code get "/questions/1" == 404
    # assert_status_code get "/questions/5" == 200
    # # assert_status_code get {"/questions/5", %{}} == 200
    # # assert_status_code post "/", %{} = 201

    # assert_response get "id" == %{:data => %{"foo": "bar"}}
    # assert_response get "/offers" == %{:data => %{"foofer" => "boffer"}}

    # assert_response post "/users", hash == %{:data => %{"foo" => "bar"}}
    # assert_response get index == %{:data => %{}}
  end


end
