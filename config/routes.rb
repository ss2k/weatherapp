Rails.application.routes.draw do
  root 'components#index'
  namespace :api do
    namespace :v1 do
      get 'searches/data' => 'searches#data'
    end
  end
end
