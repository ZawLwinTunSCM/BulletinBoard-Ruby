Rails.application.routes.draw do
  root 'login#loginP'

  #login
  get '/login', to: 'login#loginP'
  post '/login', to: 'login#login'
  get '/logout', to: 'login#logout'

  #user
  resources :users
  get '/edit_password', to: 'users#edit_password'
  post '/update_password', to: 'users#update_password'

  #reset password
  get 'forgot_password', to: 'password_reset#forgot_password'
  post 'email_check', to: 'password_reset#email_check'
  get 'reset_password', to: 'password_reset#reset_password'
  post 'reset_password', to: 'password_reset#update_password'

  #post
  resources :posts
  get 'download_csv', to: 'posts#download_csv'
  get 'upload_csv', to: 'posts#upload_csv'
  post 'import_csv', to: 'posts#import_csv'
end
