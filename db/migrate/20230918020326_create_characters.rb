class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|

      t.string :name
      t.string :icon
      t.integer :personality, default: 0
      t.integer :speak_type, default: 0
      t.integer :business, default: 0
      t.integer :given_name, default: 0
      t.integer :age, default: 0
      t.integer :gender, default: 0
      t.timestamps
    end
  end
end
