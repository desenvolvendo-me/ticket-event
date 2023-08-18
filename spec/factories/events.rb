# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  description :string
#  info        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :event do
    description { "Bootcamp Imersão 1ª Vaga" }
    info { "No dia 11/06 às 8h" }
    template { Rack::Test::UploadedFile.new('spec/support/ticket.svg', 'image/svg') }
  end
end
