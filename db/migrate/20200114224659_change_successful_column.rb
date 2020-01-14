class ChangeSuccessfulColumn < ActiveRecord::Migration
  def change
    rename_column :goals, :successful?, :successful
  end
end
