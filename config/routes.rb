Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'cellphones',to:'users/registrations#new_cellphone'
    post 'cellphones',to:'users/registrations#create_cellphone'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'credit_cards', to: 'users/registrations#new_credit_card'
    post 'credit_cards', to: 'users/registrations#create_credit_card'
  end

  root "products#index"

  resources :products, only: [:index,:new,:create,:show] do
    collection do
      get 'user_credit'
      get 'user_profile_information'
      get 'user_logout'
      get 'user_profile_edit'
      get 'user-page'
      get 'notice'
      get 'things_to_do'
      get 'like'
      get 'exhibiting'
      get 'transaction'
      get 'sale'
      get 'purchase_exhibit'
      get 'purchase_transaction'
      get 'news'
      get 'evaluation'
      get 'contact'
      get 'guide'
      get 'buy_confirm'
    end
  end
end
