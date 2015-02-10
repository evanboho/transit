Rails.application.routes.draw do

  namespace :v1 do
  get 'stops/index'
  end

  namespace :v1 do
  get 'stops/show'
  end

  get '/nearby', to: 'static#nearby'

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
      resources :routes, only: [:index] do
        resources :stops, only: [:index] do
          get 'departures', to: 'departures#index', as: 'stop_departures'
        end
      end
    end
  end

  namespace 'v1' do
    resources :stops
  end

  resources :agencies, only: [:index] do
    resources :routes, only: [:index] do
      get '(:direction)/stops', to: 'stops#index', as: 'stops'
      get '(:direction)/stops/:stop_id', to: 'departures#index', as: 'stop_departures'
    end
  end

  root to: 'static#home'

end
