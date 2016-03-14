defmodule HeatGraph.Router do
  use HeatGraph.Web, :router

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

  scope "/", HeatGraph do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/sensors",  SensorController
    get "/sensors/:id/flot", SensorController, :flot

    resources "/readings", ReadingController
  end

  scope "/api_v1", HeatGraph do
    pipe_through :api

    post "/reading", ReadingController, :create_api
  end
end
