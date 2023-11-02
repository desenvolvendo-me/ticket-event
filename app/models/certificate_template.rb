# == Schema Information
#
# Table name: certificate_templates
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  version     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class CertificateTemplate < ApplicationRecord
  has_one_attached :svg
end
