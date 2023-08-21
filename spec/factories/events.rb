# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  description :string
#  info        :string
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_events_on_slug  (slug) UNIQUE
#
FactoryBot.define do
  factory :event do
    name { "Bootcamp Imersão 1ª Vaga" }
    description { "Aprenda a conquistar sua 1ª vaga na programação mesmo sem nenhuma experiência" }
    info { "No dia 11/06 às 8h" }
    template { Rack::Test::UploadedFile.new('spec/support/ticket.svg', 'image/svg') }
  end
end
