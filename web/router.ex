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

  scope "/", Resume do
    pipe_through :browser
    coherence_routes
    # Add public routes below 
    get "/", PageController, :index
  end

  scope "/", Resume do
    pipe_through :protected
    coherence_routes :protected
    # Add protected routes below
    resources "/skills", SkillController, except: [:show, :index, :update]
    post "/skills/:id", SkillController, :update, as: :skill
    resources "/experiences", ExperienceController, except: [:show, :index]
    resources "/education", EducationController, except: [:show, :index]
    resources "/award", AwardController, except: [:show, :index]
    resources "/reference", ReferenceController, except: [:show, :index]
    get "/resume", PdfController, :export
    get "/resume/new", PdfController, :new
  end
end
