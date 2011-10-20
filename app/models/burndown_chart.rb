class BurndownChart
  attr_accessor :dates, :version, :start_date, :all_issues, :ideal, :sprint
  
  def initialize(version, issue_filter=nil)
    self.version = version
    query = {:include => [:relations_from, :relations_to], :conditions => "issues.tracker_id <> 2"}
    query[:conditions] = ["issues.tracker_id = #{issue_filter["tracker"]}"] unless issue_filter.nil?
    self.all_issues = version.fixed_issues.find(:all, query) 
    unless issue_filter.nil?
      self.all_issues = all_issues.select {|b| not b.custom_values.first(:conditions => "value = '#{issue_filter["team"]}'").nil? } unless issue_filter["team"].empty?
    end
    self.start_date = version.sprint_start_date.to_date #version.created_on.to_date
    end_date = (undefined_target_date?)? start_date + 1.month : version.effective_date.to_date
    if BurndownChart.sprint_has_ended(version) or version.completed_on
      end_date = (version.completed_on ? version.completed_on.to_date : Date.today)
    end
    self.dates = get_dates(start_date, end_date)
    self.ideal = ideal_data
    self.sprint = sprint_data
  end
  
  def sprint_data
    @sprint_data = []
    dates_until_today = dates.reject {|d| d if d > Date.today}
    dates_until_today.each do |date|
      total_remaining = 0
      entries_today_or_earlier = []
      all_issues.each do |issue|
        issue_today_or_earlier = (issue.created_on.to_date <= date)
        if issue_today_or_earlier
          entries_today_or_earlier << issue.remaining_effort_entries.select { |a| a.created_on.to_date <= date}.last
          total_remaining += entries_today_or_earlier.last.nil? ? 0 : entries_today_or_earlier.last.remaining_effort.to_f
        end
      end
      unless @sprint_data.empty?
        @sprint_data << ((total_remaining.zero? and entries_today_or_earlier.compact.empty?)? @sprint_data.last : total_remaining)
      else
        @sprint_data[0] = ((total_remaining.zero? and entries_today_or_earlier.compact.empty?)? ideal.first : total_remaining)
      end
    end
    @sprint_data
  end
  
  def ideal_data
    issues = all_issues.select {|issue| issue.created_on.to_date <= dates.first }
    total_estimated = 0
    issues.each do |issue|
      journals = issue.journals.find(:all, :include => [:user, :details])
      estimated_effort_details = journals.map(&:details).flatten.select {|detail| 'estimated_hours' == detail.prop_key}
      details_today_or_earlier = estimated_effort_details.select {|a| a.journal.created_on.to_date <= Time.now.to_date }
      first_estimated_effort = details_today_or_earlier.sort_by {|a| a.journal.created_on }.first
      total_estimated += first_estimated_effort.value.to_f unless first_estimated_effort.nil?    #issue.estimated_hours.to_f
    end
    @ideal_data = [total_estimated]
    ideal_dates = get_ideal_dates
    days_left = ideal_dates.count - 1
    until days_left.zero?
      @ideal_data << (@ideal_data.last - (@ideal_data.last/days_left).to_f)
      days_left -= 1
    end
    @ideal_data
  end

  def get_ideal_dates
    end_date = (undefined_target_date?)? start_date + 1.month : version.effective_date.to_date
    return get_dates(start_date, end_date)
  end

  def data_and_dates
    @data1_and_dates = []
    @data2_and_dates = []
#    @data3_and_dates = []
    ideal_dates = get_ideal_dates
    final_dates = ((ideal_dates.count > dates.count)? ideal_dates : dates)
    final_dates.each_with_index do |d, i|
#      @data1_and_dates << ["#{d} 6:00AM", labor_hours[i]]
      @data1_and_dates << ["#{d} 6:00AM", ideal[i]]
      @data2_and_dates << ["#{d} 6:00AM", sprint[i]]
    end
    [@data1_and_dates, @data2_and_dates].to_json       #, @data3_and_dates]
  end

  def get_dates(start_range, end_range)
    (start_range..end_range).inject([]) { |accum, date| accum << date }.reject {|d| d if d.cwday.eql?(6) or d.cwday.eql?(7)}
  end

  def self.sprint_has_started(id)
    !Version.find_by_id(id).sprint_start_date.nil? and (Version.find_by_id(id).sprint_start_date.to_time || 1.day.from_now) <= Time.now
  end

  def self.sprint_has_ended(version)
    effective_date = if version.effective_date.nil? or version.effective_date.to_date < version.sprint_start_date.to_date
        (version.sprint_start_date.to_date + 1.month)
      else
        version.effective_date.to_date
      end
    return effective_date < Time.now.to_date
  end

  def undefined_target_date?
    version.effective_date.nil? or version.effective_date.to_date < start_date
  end

#  ready to use for labor hours.
#  def labor_hours
#    resources = version.project.members.count
#    manhours = 8
#    period = dates.count - 1
#    velocity = resources * manhours * period
#    labor_hours = [velocity]
#    (1..(period)).each do |i|
#      tmp = labor_hours[i-1] - (resources * manhours)
#      labor_hours[i] = (tmp <= 0)? 0 : tmp
#    end
#    return labor_hours
#  end

end
