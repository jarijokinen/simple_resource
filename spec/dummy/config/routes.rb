Dummy::Application.routes.draw do
  namespace :backend do
    resources :categories do
      resources :posts
    end

    resources :languages
  end

  resources :categories do
    resources :posts
  end

  resources :languages
end
