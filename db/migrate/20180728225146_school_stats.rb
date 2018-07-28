class SchoolStats < ActiveRecord::Migration[5.2]
  def change
    create_table :school_stats do |t|
      t.string :lat, null: false, default: ""
      t.string :lon, null: false, default: ""
      t.string :name, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :grade, null: false, default: ""
      t.boolean :transportation_provided, null: false, default: false
      t.string :language_immersion, null: false, default: ""
    end
  end
end
