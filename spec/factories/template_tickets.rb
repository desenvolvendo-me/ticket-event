# == Schema Information
#
# Table name: template_tickets
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  version     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :template_ticket do
    name { 'Preto e Branco' }
    description { "Ingresso na vertical com as cores preto e branco que permite alterar DATA_EVENTO, NOME, FOTO e NUMERO" }
    version { "1" }
    svg { Rack::Test::UploadedFile.new('spec/support/ticket.svg', 'image/svg') }
  end
end
