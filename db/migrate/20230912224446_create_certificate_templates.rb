class CreateCertificateTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :certificate_templates do |t|
      t.string :description
      t.string :name
      t.string :version

      t.timestamps
    end
  end
end
