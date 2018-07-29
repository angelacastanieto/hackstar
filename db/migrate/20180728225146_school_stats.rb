class SchoolStats < ActiveRecord::Migration[5.2]
  def change
    create_table :school_stats do |t|
      t.string :name, null: false, default: ""
      t.string :num, null: false, default: ""
      t.string :grade, null: false, default: ""
      t.string :b_cantonese, null: false, default: ""
      t.string :b_spanish, null: false, default: ""
      t.string :i_cantonese, null: false, default: ""
      t.string :i_korean, null: false, default: ""
      t.string :i_mandarin, null: false, default: ""
      t.string :i_spanish, null: false, default: ""
      t.string :f_filipino, null: false, default: ""
      t.string :f_japanese, null: false, default: ""
      t.string :n_chinese, null: false, default: ""
      t.string :middle, null: false, default: ""
      t.int :start_time, null: true
      t.string :zipcode, null: true
    end
  end
end
