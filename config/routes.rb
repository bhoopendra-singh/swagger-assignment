Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    get 'get_token', to: 'urls#get_token'
    resources :urls, only: [:create, :show]
  end

end

