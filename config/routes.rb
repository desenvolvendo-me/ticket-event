Rails.application.routes.draw do
  devise_for :manager_users
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  root to: "welcome#index"
  get 'welcome/index'

  namespace :manager do
    get 'home', to: "home#index", as: :home

    resources :events do
      member do
        post :run_prize_draw
      end
    end

    resources :lessons

    resources :students do
      collection do
        get :select_student_csv
        post :import_student_csv
      end

      member do
        get :select_event
        post :create_certificate
      end
    end

    resources :tickets, only: [:index, :show]
    get 'select_student_csv', to: "tickets#select_student_csv", as: :tickets_select_student_csv
    post 'import_student_csv', to: "tickets#import_student_csv", as: :tickets_import_student_csv
  end

  scope module: :external do
    get ':slug_event/ticket', to: "tickets#search", as: :search_ticket
    post 'ticket/form', to: "tickets#form", as: :form_ticket
    get ':slug_event/ticket/:phone', to: "tickets#ticket", as: :event_ticket
    get ':slug_event/ticket/:phone/edit', to: "tickets#edit", as: :edit_event_ticket
    put ':slug_event/ticket/:phone/update', to: "tickets#update", as: :update_event_ticket

    get ':slug_event/certificate/:phone', to: "certificates#certificate", as: :event_certificate
    get ':slug_event/certificate/:phone/share', to: "certificates#share", as: :event_certificate_share
    get ':slug_event/certificate', to: "certificates#search", as: :search_certificate
    post 'certificate/form', to: "certificates#form", as: :form_certificate

    get ':slug_event/checkin', to: "checkins#search", as: :search_checkin
    post 'checkin/form', to: "checkins#form", as: :form_checkin
    get ':slug_event/checked/:phone', to: "checkins#checked", as: :checked_checkin

    get ':slug_event/lessons', to: "lessons#index", as: :lessons_index
    get ':slug_event/lessons/:lesson_id', to: "lessons#show", as: :lesson
    get ':slug_event/lessons/:lesson_id/search', to: "lessons#search", as: :lesson_validate
    post ':slug_event/lessons/:lesson_id/search', to: "lessons#form", as: :form_lesson

    get ':slug_event/lessons/:lesson_id/quiz', to: "quiz#show", as: :quiz
    post ':slug_event/lessons/:lesson_id/quiz/submit', to: "quiz#submit", as: :quiz_submit
    get ':slug_event/lessons/:lesson_id/quiz/result', to: "quiz#result", as: :quiz_result

    get ':slug_event', to: "events#index", as: :event
  end
end
