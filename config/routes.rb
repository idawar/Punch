Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :employees, except: [:edit, :destroy]
    resources :clients, except: [:edit, :destroy]
	resources :projects, except: [:edit, :destroy]
end
