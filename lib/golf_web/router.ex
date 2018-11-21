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

    resources "/courses", CourseController
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", GolfWeb do
  #   pipe_through :api
  # end
end