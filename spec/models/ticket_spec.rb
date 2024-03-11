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
#  student_id      :bigint           not null
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
require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should belong_to(:event)}
  it { should belong_to(:student)}
  it { should have_one_attached(:svg)}
  it { should have_one_attached(:png)}

  describe 'create' do
    it '# create a valid ticket' do
      ticket = create(:ticket)
      expect(ticket).to be_valid
    end
  end

  describe 'update' do
    it "# updates a ticket - checkin field" do
      ticket = create(:ticket)
      ticket.update(checkin: true)
      expect(ticket.checkin).to eq(true)
    end

    it "# updates a ticket - student_score field" do
      ticket = create(:ticket)
      ticket.update(student_score: 1234)
      expect(ticket.student_score).to eq(1234)
    end
  end

  describe 'destroy' do
    it 'destroys a ticket' do
      ticket = create(:ticket)
      ticket.destroy
      expect(Ticket.count).to eq(0)
    end
  end
end
