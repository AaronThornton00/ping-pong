class CreateAllocation < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.references  :user, null: false
      t.references  :game, null: false
      t.integer     :score, null: false, default: 0
    end
  end
end
