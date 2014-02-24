Porlosegao::Application.routes.draw do
  devise_for :users

  resources :signed_urls, only: :index

  match 'pages/:id',
    :controller => 'pages',
    :action => 'show',
    :requirements => {:id => /[a-z]+/ }

  match 'cromos/ninki/:criteria',
    :controller => "cards",
    :action => "index"

  resources :cards, :path => :cromos do
    collection do
      get :index_ajax
    end
    resources :comments, :only => [:create]
    collection do
      post :create_cromo
      get :nuevos
    end
  end

  match "cromosImagen/:id" => 'cards#from_picture'
  resources :pictures do
    collection do
      get :nuevas
    end
    member do
      post :bautizer
    end
  end
  resources :users do
    collection do
      post :vote_card
    end
  end

  root :to => 'cards#nuevos'

end
