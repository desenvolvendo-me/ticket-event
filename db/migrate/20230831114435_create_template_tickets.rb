class CreateTemplateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :template_tickets do |t|
      t.string :name
      t.string :description
      t.string :version

      t.timestamps
    end
  end
end
