class AddCompletedOnToVersion < ActiveRecord::Migration
  def self.up
    add_column :versions, :completed_on, :date
  end

  def self.down
    remove_column :versions, :completed_on
  end
end
