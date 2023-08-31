# == Schema Information
#
# Table name: template_tickets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TemplateTicket < ApplicationRecord
  has_one_attached :svg
end
