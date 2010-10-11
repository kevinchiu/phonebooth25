class ChangePhone < ActiveRecord::Migration
  def self.up
    change_column :transcripts, :phone, :string
  end

  def self.down
    change_column :transcripts, :phone, :integer
  end
end
