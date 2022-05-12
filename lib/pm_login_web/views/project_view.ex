defmodule PmLoginWeb.ProjectView do
  alias PmLoginWeb.LiveComponent.{
    TaskModalLive,
    PlusModalLive,
    ModifModalLive,
    ModifModalMenu,
    CommentsModalLive,
    CommentsModalMenu,
    SecondaryModalLive,
    DeleteTaskModal
  }

  alias PmLogin.Monitoring
  alias PmLogin.Utilities
  use PmLoginWeb, :view
end
