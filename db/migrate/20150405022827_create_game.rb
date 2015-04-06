class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :start_at
      t.datetime :end_at
    end
  end
end
