class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.text :comment

      t.timestamps
    end
  end
end
