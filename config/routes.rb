TutorialAssociation::Application.routes.draw do
  resources :appointments

  resources :patients

  resources :physicians

  resources :orders

  resources :customers

end
