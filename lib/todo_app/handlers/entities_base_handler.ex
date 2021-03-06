defmodule TodoApp.Entities.BaseHandler do
  defmacro __using__(_opts) do
    quote do
      alias TodoApp.Repo
      import Ecto
      import Ecto.Query
      import TodoApp.Handler.Helpers

      # Default REST Callbacks

      def init({:tcp, :http}, req, _opts) do
        {:upgrade, :protocol, :cowboy_rest}
      end

      def content_types_provided(req, state) do
        {[{"application/json", :handle_get}], req, state}
      end

      def content_types_accepted(req, state) do
        {[{"application/json", :handle_post}], req, state}
      end

      def allowed_methods(req, state) do
        {["GET", "OPTIONS", "POST"], req, state}
      end

      def options(req, state) do
        req = set_headers(req, default_headers)
        {:ok, req, state}
      end

      defoverridable [allowed_methods: 2]
    end
  end
end
