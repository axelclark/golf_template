defmodule GolfWeb.Router do
  use GolfWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GolfWeb do
    pipe_through :browser

    resources "/scores", ScoreController
    resources "/rounds", RoundController
    resources "/courses", CourseController
    resources "/holes", HoleController
    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: GolfWeb.Schema

    forward "/", Absinthe.Plug,
      schema: GolfWeb.Schema
  end
end
