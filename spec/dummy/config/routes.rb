Dummy::Application.routes.draw do
  resources :categories do
    resources :posts
  end
  resources :languages
end
