Rails.application.routes.draw do
  
  devise_for :users
  
  #homes\controller
  root to: 'homes#top'
 
end
