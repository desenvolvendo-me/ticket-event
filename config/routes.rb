Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  root to: "welcome#index"
  get 'welcome/index'

  put ':slug_event/ticket/:phone/update', to: "tickets#update", as: :update_event_ticket
  get ':slug_event/ticket/:phone/edit', to: "tickets#edit", as: :edit_event_ticket
  get ':slug_event/ticket/:phone', to: "tickets#ticket", as: :event_ticket
  post 'ticket/form', to: "tickets#form", as: :form_ticket
  get ':slug_event/ticket', to: "tickets#search", as: :search_ticket
end
