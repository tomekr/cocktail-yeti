Rails.application.routes.draw do
  root 'static_pages#home'
  post "/graphql", to: "graphql#execute"
  get "/heartbeat", to: "application#heartbeat"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
end
