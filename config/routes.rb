Rails.application.routes.draw do
  resources :candidates do
    member do
      post:vote
      # 路徑會帶id
    end

    # collection do
    #   post :vote
    #   # 路徑不會帶id
    # end
  end
  # post '/condidate/:id/vote', to: 'candidate#vote'

  # get '/hello.php', to: 'candidates#index'
end
