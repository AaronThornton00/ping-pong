class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime    :start_at,  null: false
      t.datetime    :end_at,    null: false
      t.integer     :duration,  null: false
      t.references  :winner,    null: true
      t.references  :looser,    null: true
    end
  end
end
