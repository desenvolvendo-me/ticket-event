Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  root to: "welcome#index"
  get 'welcome/index'

  get ':slug_event/ticket/:phone', to: "tickets#ticket", as: :event_ticket
  post 'ticket/form', to: "tickets#form"
  get ':slug_event/ticket', to: "tickets#search", as: :search_ticket
end
