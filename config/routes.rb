Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [:index,:show] do
    collection do
      get 'my_page'
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
    end
  end
end
