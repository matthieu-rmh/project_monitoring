defmodule PmLoginWeb.ProjectView do
  alias PmLoginWeb.LiveComponent.{
    TaskModalLive,
    PlusModalLive,
    ModifModalLive,
    ModifModalMenu,
    CommentsModalLive,
    CommentsModalMenu,
    SecondaryModalLive,
    # DeleteTaskModal,
    ClientModalRequestLive,
    DetailModalRequestLive,
    ProjectModalLive,
    TaskLiveComponent,
    ProjectLiveComponent,
    UserLiveComponent,
    SidebarLiveComponent,
    ActivityLiveComponent,
    CompletedActivitiesLiveComponent
  }

  alias PmLogin.Monitoring
  alias PmLogin.Utilities
  use PmLoginWeb, :view
end
