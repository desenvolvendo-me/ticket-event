Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  root to: "welcome#index"
  get 'welcome/index'

  get ':slug_event/ticket', to: "tickets#search", as: :search_ticket
  post 'ticket/form', to: "tickets#form", as: :form_ticket
  get ':slug_event/ticket/:phone', to: "tickets#ticket", as: :event_ticket
  get ':slug_event/ticket/:phone/edit', to: "tickets#edit", as: :edit_event_ticket
  put ':slug_event/ticket/:phone/update', to: "tickets#update", as: :update_event_ticket

  get ':slug_event/certificate/:phone', to: "certificates#certificate", as: :event_certificate
  get ':slug_event/certificate', to: "certificates#search", as: :search_certificate
  post 'certificate/form', to: "certificates#form", as: :form_certificate

  get ':slug_event/checkin', to: "checkins#search", as: :search_checkin
  post 'checkin/form', to: "checkins#form", as: :form_checkin
  get ':slug_event/checked/:phone', to: "checkins#checked", as: :checked_checkin

  get ':slug_event/lessons', to: "lessons#index"
  get ':slug_event/lessons/:lesson_id/quiz', to: "quiz#show", as: :quiz
  post ':slug_event/lessons/:lesson_id/quiz/submit', to: "quiz#submit", as: :quiz_submit
  get ':slug_event/lessons/:lesson_id/quiz/result', to: "quiz#result", as: :quiz_result

  get ':slug_event/events', to: "events#index"
end
