Rails.application.routes.draw do

  get '/nearby', to: 'static#nearby'

  namespace 'api511', path: '511' do
    resources :agencies, only: [:index] do
      resources :routes, only: [:index] do
        get '(:direction)/stops', to: 'stops#index'
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
      get 'departures/:stop_id', to: 'departures#index', as: 'departures'
    end
  end

  namespace 'v1' do
    get 'stops/near', to: 'stops#near', as: 'stops_near'
    resources :routes, only: [:index, :show] do
      resources :stops, only: [:index, :show]
    end
    resources :stops, only: [:index, :show]
  end

  namespace 'bart' do
    resources :routes, only: [:index, :show]
    resources :stops, only: [:show] do
      resources :departures, only: [:show]
    end
    resources :departures, only: [:index]
  end

  resources :agencies, only: [:index] do
    resources :routes, only: [:index] do
      get '(:direction)/stops', to: 'stops#index', as: 'stops'
      get '(:direction)/stops/:stop_id', to: 'departures#index', as: 'stop_departures'
    end
  end


  root to: 'static#home'

end
