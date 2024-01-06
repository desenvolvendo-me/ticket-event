# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  community_link :string
#  date           :datetime
#  description    :string
#  launch         :integer
#  name           :string
#  purchase_date  :datetime
#  purchase_link  :string
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_events_on_slug  (slug) UNIQUE
#
FactoryBot.define do
  factory :event do
    name { "Bootcamp Imersão 1ª Vaga" }
    launch { rand(1..100) }
    description { "Aprenda a conquistar sua 1ª vaga na programação mesmo sem nenhuma experiência" }
    date { (Date.today + 20.hours + 30.minutes) + 21.days }
    template { Rack::Test::UploadedFile.new('spec/support/ticket.svg', 'image/svg') }
    certificate_template { Rack::Test::UploadedFile.new('spec/support/certificate_template.svg', 'image/svg+xml') }
    slug { FFaker::Internet.slug }
  end
end
