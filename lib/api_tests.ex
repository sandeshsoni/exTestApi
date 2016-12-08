defmodule ApiTestError do
  #

  def message(exception) do
    #
  end
end


defmodule ApiTests do

  @endpoint "not set"

  @doc """
  assert_status_code get "2" == 200
  assert_status_code get {3,params} == 200
  assert_response get 1 == expected_resp_obj
  assert_response get 1 =~ expected_resp_obj_pattern
  assert post index == %{"greet": "hello"}
  assert_status_code create "url" == 201
  assert_status_code delete 'id' == 200
  """

  def post(url, params = %{}) do
    IO.puts "post post post"
  end

  defmacro assert_status_code({:==, _meta, [response, expected_code]}) do
    #
  end

  defmacro assert_response({:==, _meta, [response, expected_code]}) do
    #
  end

  defmacro assert_status_code({:get, _meta, [{operator, _, [url, response_code]} = opts]}) do
    # IO.puts "assert meta in status code"
    # IO.inspect opts
    IO.inspect @endpoint
    # raise "hostname and endpoint not known"
    quote do
      # # def test_stat_code(unquote(url), unquote(response_code)), do: IO.puts "yoooo"
      for_get_request(unquote(operator), unquote(url), unquote(response_code))
    end
  end

  @doc
  """
  left = url
  right = expected response code
  """
  defmacro for_get_request(:==, left, right) do
    # Module.get_attribute __MODULE__, :endpoint
    # IO.puts "\tassert status code. endpoint is : "
    # IO.puts @endpoint
    endpoint = "http://localhost:4000/api"

    url = "#{ endpoint }#{ left }"
    case HTTPoison.get(url) do
      {:ok, %{body: body, status_code: status_code} = response} ->
        ^status_code = right
      {:error, response} -> IO.puts "request failed. #{response.reason}"
    end
  end

  # defmacro assert_response(:get, meta, opts) do
  #   IO.puts("\tassert_response - GET - splitted ")
  #   # IO.inspect meta
  #   # IO.inspect opts
  #   # code = Macro.escape opts
  #   # IO.inspect code
  #   quote do
  #     # def unquote(assertion)(), do: unquote(block)
  #     # IO.puts "in quote - get - assert_response"
  #     # op = unquote(assertion)
  #     # IO.inspect op
  #     #
  #   end
  # end

  # defmacro assert_status_code({:get, _meta, [{operator, _, [url, response_code]} = opts]}) do
  defmacro assert_response({:get, meta, [{operator, _, [url,resp]} = opts]}) do
    IO.puts("assert_response - GET - ")
    IO.puts operator
    IO.puts "url : " <> url
    IO.puts "response : "
    IO.inspect resp
    # IO.inspect assertion
    # left = Macro.expand(left, __CALLER__)
    quote do
    end
  end

  defmacro __using__(opts) do
    quote do
      import ApiTests
      ops = unquote(opts)
      @path ops.host
    end
  end

  defmacro test_url(description, opts, do: block) do
    IO.puts "test_ap with options :" <> description
    function_name = String.to_atom("test " <> description)
    quote do
      def unquote(function_name)(), do: unquote(block)
    end
  end

  defmacro test_url(description) do
    IO.puts "\tpending implementation : " <> "test " <> description
  end

  # defmacro test(message, var \\ quote(do: _), contents) do
  defmacro test_url(description, do: block) do
    IO.puts "test  : #{ description }"
    function_name = String.to_atom("test " <> description)
    IO.puts "fun name : #{function_name}"
    # Module.put_attribute __MODULE__, :endpoint, "endpoint"
    quote do
      @host "123"
      def unquote(function_name)(), do: unquote(block)
    end
 end

  @doc false
  defmacro __before_compile__(env) do
    IO.puts "running ... #{env}"
    Module.register_attribute __MODULE__, :endpoint, accumulate: true, persist: true
    quote do
      def run do
        # @index fn name -> IO.puts("...nnnn") end
        IO.puts "running ..."
        # IO.inspect @path
      end
    end
  end

  def message(exception) do
    # message to print on console
  end

  defp formatter do
    #
  end

  # defp check_index_status do
  #   case HTTPoison.get(@path) do
  #     {:ok, _response} -> IO.puts "ok"
  #     {:error, _response} -> IO.puts "failed"
  #   end
  # end

  # defp call_api() do
  #  # JSON response and readable JSON response
  # end

end
