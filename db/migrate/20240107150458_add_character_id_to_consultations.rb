class AddCharacterIdToConsultations < ActiveRecord::Migration[7.0]
  def change
    add_column :consultations, :character_id, :integer
  end
end
