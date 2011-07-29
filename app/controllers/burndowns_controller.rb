class BurndownsController < ApplicationController
  unloadable
  menu_item :burndown

  before_filter :find_version_and_project, :authorize, :only => [:show, :chart]

  def show
  
  end

  def chart
    render :partial => 'chart'
  end

  def graph_code
    
    # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/data-lines-2.php
    # and parts from this example - http://teethgrinder.co.uk/open-flash-chart-2/x-axis-labels-3.php
    title = Title.new("")

#    data1 = [] 
#    data2 = [] 

     data = BurndownChart.bd_data
     data1 = data[0]
     data2 = data[1]

    line_dot = LineDot.new
    line_dot.width = 4
    line_dot.colour = '#DFC329'
    line_dot.dot_size = 5
    line_dot.set_key('Ideal data',10)
    line_dot.values = data1

    line_hollow = LineHollow.new
    line_hollow.width = 1
    line_hollow.colour = '#6363AC'
    line_hollow.dot_size = 5
    line_hollow.set_key('Sprint data',10)
    line_hollow.values = data2

    tmp = []
    x_labels = XAxisLabels.new
    x_labels.set_vertical()

    BurndownChart.bd_dates.each do |text|
      tmp << XAxisLabel.new(text, '#0000ff', 12, 'diagonal')
    end

    x_labels.labels = tmp

    x = XAxis.new
    x.set_labels(x_labels)

    y = YAxis.new
    y.set_range(0,((data[2].to_i > 20)? data[2].to_i+5 : 20),5)

    x_legend = XLegend.new("Dates")
    x_legend.set_style('{font-size: 18px; color: #778877}')

    y_legend = YLegend.new("Hours")
    y_legend.set_style('{font-size: 18px; color: #770077}')

    chart =OpenFlashChart.new
    chart.set_title(title)
    chart.set_x_legend(x_legend)
    chart.set_y_legend(y_legend)
    chart.x_axis = x # Added this line since the previous tutorial
    chart.y_axis = y

    chart.add_element(line_dot)
    chart.add_element(line_hollow)

    render :text => chart.to_s
  end

private
  def find_version_and_project
    @project = Project.find(params[:project_id])
    @version = params[:id] ? @project.versions.find(params[:id]) : @project.current_version
    render_error(l(:burndown_text_no_sprint)) and return unless @version
    @chart = BurndownChart.new(@version)
    @graph = open_flash_chart_object('100%','100%',"/burndowns/graph_code")
  end
end
