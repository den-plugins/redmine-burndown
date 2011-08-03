class BurndownChart
  attr_accessor :dates, :version, :start_date
  
  delegate :to_s, :to => :dates
  
  def initialize(version)
    self.version = version
    
    self.start_date = version.created_on.to_date
    end_date = version.effective_date.to_date
    self.dates = (start_date..end_date).inject([]) { |accum, date| accum << date }
#    @@sprint_data = sprint_data
#    @@ideal_data = ideal_data
#    @@dates = dates.map {|d| d.strftime("%m-%d-%y") }
#    @@max_sprint = sprint_data.max
  end
  
  def sprint_data
    @sprint_data ||= dates.map do |date|
      issues = all_issues.select {|issue| issue.created_on.to_date <= date }
      issues.inject(0) do |total_hours_left, issue|
        done_ratio_details = issue.journals.map(&:details).flatten.select {|detail| 'done_ratio' == detail.prop_key }
        details_today_or_earlier = done_ratio_details.select {|a| a.journal.created_on.to_date <= date }

        last_done_ratio_change = details_today_or_earlier.sort_by {|a| a.journal.created_on }.last

        ratio = if last_done_ratio_change
          last_done_ratio_change.value
        elsif done_ratio_details.size > 0
          0
        else
          issue.done_ratio.to_i
        end
        
        total_hours_left += (issue.estimated_hours.to_i * (100-ratio.to_i)/100)
      end
    end
  end
  
  def ideal_data
    ideal = [sprint_data.first]
    ideal[sprint_data.size-1] = 0
    ideal
  end
  
  def all_issues
    version.fixed_issues.find(:all, :include => [{:journals => :details}, :relations_from, :relations_to])
  end

  def data_and_dates
    @data1_and_dates = []
    @data2_and_dates = []
    dates.each_with_index do |d, i|
      @data1_and_dates << ["#{d} 8:00AM", sprint_data[i]]
      @data2_and_dates << ["#{d} 8:00AM", ideal_data[i]]
    end
    [@data1_and_dates, @data2_and_dates]
  end

#  def self.bd_data
#    [@@ideal_data, @@sprint_data, @@max_sprint]
#  end
#  
#  def self.bd_dates
#    @@dates
#  end

#  def chart_cont_width
#    width = 1000
#    if @@dates.size >= 50
#      width = @@dates.size * 5
#    end
#  end

end
