# == Schema Information
#
# Table name: tickets
# Table name: tickets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  student_id :bigint           not null
#
# Indexes
#
#  index_tickets_on_event_id    (event_id)
#  index_tickets_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (student_id => students.id)
#
FactoryBot.define do
  factory :ticket do
    svg { Rack::Test::UploadedFile.new('spec/support/ticket-success.svg', 'image/svg')  }
    png { Rack::Test::UploadedFile.new('spec/support/ticket-success.svg', 'image/svg')  }
  end
end
