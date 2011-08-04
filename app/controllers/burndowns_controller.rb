class BurndownsController < ApplicationController
  unloadable
  menu_item :burndown

  before_filter :find_version_and_project, :authorize, :only => [:show, :chart]

  def show
#    @data = BurndownChart.bd_data
  end

  def chart
    render :partial => 'chart'
  end

private
  def find_version_and_project
    @project = Project.find(params[:project_id])
    @version = params[:id] ? @project.versions.find(params[:id]) : @project.current_version
    render_error("No sprint.") and return unless @version
    if !@version.effective_date.nil?
      @chart = BurndownChart.new(@version)
    else
      render :partial => "burndowns/no_sprint"
    end
  end
end
