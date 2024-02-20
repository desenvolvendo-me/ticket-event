class AddVerificationLinkToCertificates < ActiveRecord::Migration[7.0]
  def change
    add_column :certificates, :verification_link, :string
  end
end
