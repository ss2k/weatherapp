class CreateCaches < ActiveRecord::Migration[7.0]
  def change
    create_table :caches do |t|
      t.string :postal, null: false
      t.jsonb :data, null: false, default: {}

      t.timestamps
    end

    add_index :caches, :postal
    add_index :caches, :updated_at
  end
end
