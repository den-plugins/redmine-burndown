class BurndownsController < ApplicationController
  unloadable
  menu_item :burndown

  before_filter :find_version_and_project, :authorize, :only => [:show, :chart, :start_sprint]

  def show
#    @data = BurndownChart.bd_data
  end

  def chart
    render :partial => 'chart'
  end

  def start_sprint
    @version.sprint_start_date = Time.now
    @version.save
    redirect_to show_burndown_path(@project, @version)
  end

private
  def find_version_and_project
    @project = Project.find(params[:project_id])
    @version = params[:id] ? @project.versions.find(params[:id]) : @project.current_version
#    render_error("No sprint.") and return unless @version
    if @version and BurndownChart.sprint_has_started(@version.id)
      puts BurndownChart.sprint_has_started(@version.id)
      @chart = BurndownChart.new(@version)
    else
      @chart = nil
    end
  end
end
