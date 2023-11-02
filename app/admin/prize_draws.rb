ActiveAdmin.register PrizeDraw do
  permit_params :ticket_id
  actions :index, :show

  controller do
    def scoped_collection
      PrizeDraw.includes(ticket: [:event, :student])
    end
  end

  index do
    id_column
    column(:event) { |prize_draw| prize_draw.ticket.event }
    column :ticket
    column(:student) { |prize_draw| prize_draw.ticket.student }
    column :date, :created_at
    actions
  end

  show do
    attributes_table do
      row(:event) { |prize_draw| prize_draw.ticket.event }
      row(:student) { |prize_draw| prize_draw.ticket.student }
      row :ticket
      row(:date) { |prize_draw| prize_draw.created_at }
    end
  end
end
