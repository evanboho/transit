Rails.application.routes.draw do

  namespace 'api511', path: '511' do
    resources :agencies, only: [:index] do
      resources :routes, only: [:index] do
        get '(:direction)', to: 'stops#index'
      end
    end
    get 'departures/:stop_id', to: 'departures#index'
  end

  namespace 'next_bus', path: 'nb' do
    resources :agencies, only: [:index] do
      resources :routes, only: [:index, :show]
    end
  end

  resources :agencies, only: [:index] do
    resources :routes, only: [:index] do
      get '(:direction)/stops', to: 'stops#index'
      get '(:direction)/stops/:stop_id', to: 'departures#index'
    end
  end

  root to: redirect('/agencies')

end
