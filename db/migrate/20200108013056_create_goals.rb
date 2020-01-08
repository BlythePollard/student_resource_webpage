class CreateGoals < ActiveRecord::Migration
  def change
      create_table :goals do |t|
        t.string :content
        t.string :date_created
        t.string :completion_goal_date
        t.integer :successful?
        t.integer :user_id
    end
  end
end
