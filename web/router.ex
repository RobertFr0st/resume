defmodule Resume.Router do
  use Resume.Web, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  scope "/" do
    pipe_through :browser
    coherence_routes
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/", Resume do
    pipe_through :browser # Use the default browser stack
    # Add public routes below
    get "/", PageController, :index
  end

  #protected means if you are not logged in redirects you to user login page
  scope "/", Resume do
    pipe_through :protected
    # Add protected routes below
    resources "/users", UserController
    put "/lock/:id", UserController, :lock
    put "/unlock/:id", UserController, :unlock
    put "/confirm/:id", UserController, :confirm
  end
end
