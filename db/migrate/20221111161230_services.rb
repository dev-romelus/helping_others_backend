class Services < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string :description
      t.string :request_type
      t.boolean :status
      t.decimal :latitude, precision: 15, scale: 10, default: 0.0, null: false
      t.decimal :longitude, precision: 15, scale: 10, default: 0.0, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
