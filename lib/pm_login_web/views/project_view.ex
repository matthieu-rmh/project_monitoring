defmodule PmLoginWeb.ProjectView do
  alias PmLoginWeb.LiveComponent.{
    SurveyLiveComponent,
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
    CompletedActivitiesLiveComponent,
    Loading
  }

  alias PmLogin.Monitoring
  alias PmLogin.Utilities
  use PmLoginWeb, :view
end
