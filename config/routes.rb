Rails.application.routes.draw do
  post 'classification/train', as: '/train'
  get 'classification/classify', as: '/classify'

  root to: 'classification#index'
end
