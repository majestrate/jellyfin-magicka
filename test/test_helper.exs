ExUnit.start()

Mix.Task.run("jellyfin", "compile")

defmodule JellyfinTest.Plug do
  defmacro __using__(server) do
    quote do
      use Plug.Test
      use ExUnit.Case
      alias Plug.Conn.Utils
      alias Plug.Conn.Status

      @server unquote(server)
      @opts @server.init([])

      defmodule State do
        defstruct conn: nil, name: nil
      end

      def was_sent_and(test_state, state \\ :sent) do
        assert test_state.conn.state == state,
               "#{test_state.name} response state was '#{test_state.conn.state}' not '#{state}'"

        test_state
      end

      def had_status_and(test_state, status) do
        conn_status = Status.reason_atom(test_state.conn.status)

        assert conn_status == status,
               "#{test_state.name} got status '#{conn_status}' but we wanted '#{status}'"

        test_state
      end

      def was_ok_and(test_state) do
        had_status_and(test_state, :ok)
      end

      def had_content_type_and(test_state, ctype) do
        {:ok, _, conn_ctype, _} =
          test_state.conn |> get_resp_header("content-type") |> Enum.at(0) |> Utils.content_type()

        assert ctype == conn_ctype,
               "#{test_state.name} had content type #{conn_ctype} not #{ctype}"

        test_state
      end

      def was_redirected_and(test_state) do
        status = Status.reason_atom(test_state.conn.status)

        msg =
          "#{test_state.name} did not redirect but we wanted it to, got status '#{status}' instead"

        assert test_state.conn.status >= 300 and test_state.conn.status < 400, msg
        refute status == :not_modified, msg
        refute status == :use_proxy, msg
        refute status == :switch_proxy, msg
        test_state
      end

      def was_redirected_to_and(test_state, to) do
        test_state = test_state |> was_redirected_and()
        location = test_state.conn |> get_resp_header("location") |> Enum.at(0)

        assert location == to,
               "#{test_state.name} redirected to the wrong place wanted '#{to}' but got '#{location}'"

        test_state
      end

      def was_not_redirected_and(test_state) do
        status = Status.reason_atom(test_state.conn.status)
        msg = "#{test_state.name} redirected and we did not expect this. status was '#{status}'"
        refute status == :multiple_choices, msg
        refute status == :moved_permanently, msg
        refute status == :found, msg
        refute status == :see_other, msg
        refute status == :temporary_redirect, msg
        refute status == :permanent_redirect, msg
        test_state
      end

      def ok(_) do
        :ok
      end

      def req_and_test(path, method \\ :get) do
        conn = conn(method, path) |> @server.call(@opts)
        %State{conn: conn, name: "[#{method} #{path}]"}
      end
    end
  end
end
