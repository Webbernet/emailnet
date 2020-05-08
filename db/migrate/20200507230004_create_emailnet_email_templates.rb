class CreateEmailnetEmailTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :emailnet_email_templates do |t|
      t.string :identifier, null: false, unique: true, index: true
      t.text :payload_json, null: false
      t.text :payload_html, null: false
      t.timestamps
    end
  end
end
