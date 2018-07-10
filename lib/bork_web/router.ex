defmodule BorkWeb.Router do
  use BorkWeb, :router

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

  scope "/api", BorkWeb.Api do
    pipe_through :api

    get "/user-id", UserController, :index
    resources "/postits", PostitController
    resources "/categories", CategoryController, only: [:index]
    resources "/closures", ClosureController, only: [:create]
    resources "/sprints", SprintController, only: [:index]
    resources "/squads", SquadController, only: [:index]
  end

  scope "/", BorkWeb do
    pipe_through :browser # Use the default browser stack

    get "/*path", ApplicationController, :index
  end
end
