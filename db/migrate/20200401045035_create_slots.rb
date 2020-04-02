class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.string :title
      t.datetime :start_at
      t.datetime :end_at
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
