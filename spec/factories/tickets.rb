# == Schema Information
#
# Table name: tickets
#
#  id              :bigint           not null, primary key
#  checkin         :boolean
#  number          :string
#  send_email_at   :datetime
#  student_answers :json
#  student_score   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  event_id        :bigint           not null
#  prize_draw_id   :bigint
#  student_id      :bigint           not null
#
# Indexes
#
#  index_tickets_on_event_id       (event_id)
#  index_tickets_on_prize_draw_id  (prize_draw_id)
#  index_tickets_on_student_id     (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (prize_draw_id => prize_draws.id)
#  fk_rails_...  (student_id => students.id)
#
FactoryBot.define do
  factory :ticket do
    event
    student
    student_score { rand(0..100) }
  end
end
