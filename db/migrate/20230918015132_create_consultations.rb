class CreateConsultations < ActiveRecord::Migration[7.0]
  def change
    create_table :consultations do |t|

      t.string :message, null: false
      t.string :title, null: false
      t.integer :public_status, null: false, default: 0
    
      t.timestamps
    end
  end
end
