class CreateTranscripts < ActiveRecord::Migration
  def self.up
    create_table :transcripts do |t|
      t.integer :phone
      t.text :question
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :transcripts
  end
end
