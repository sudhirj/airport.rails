Airail::Application.routes.draw do  
  match '__login__'  => 'home#login', as: :login
  root :to => 'home#index'
  match '*path' => 'home#index'
end
