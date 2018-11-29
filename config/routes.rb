Rails.application.routes.draw do
  get 'subscriptions/index'
  get 'alert' => 'dashboard#how'
  get 'people' => 'installations#users'

  get 'subscriptions/update'
  #
  # get 'subscriptions/user_params'

  resources :installations, :subscriptions, :stats, :measurements, :stations
  # resources :subscriptions
  devise_for :users
  # resources :stats
  # resources :measurements
  # resources :stations
  root 'dashboard#live'
  # root 'dashboard#rest'

  get 'aktualnosci/listopad2017' => 'news#november'
  get 'aktualnosci/grudzien2017' => 'news#december'
  get 'aktualnosci/styczen2018' => 'news#january'
  get 'aktualnosci/luty2018' => 'news#february'
  get 'aktualnosci/marzec2018' => 'news#march'
  get 'aktualnosci/pomiary' => 'news#measurements'
  # get 'widget/air' => 'widget#air'
  get 'kontakt' => 'dashboard#contact'
  get 'deadline' => 'dashboard#deadline'
  get 'widgety' => 'dashboard#widgety'
  get 'jawpl' => 'dashboard#jawpl'
  get 'nazywo' => 'dashboard#index'
  get 'rest' => 'dashboard#live'
  get 'pone' => 'news#pone'
  get 'test' => 'news#test'
  get 'test2' => 'news#test2'
  get 'wios_v_airly' => 'news#wios_v_airly'

  get "/list" => redirect("http://www.jaworznobezsmogu.pl/list.pdf")

  get '/widgets/:template', to: 'widgets#show'
  post 'options', to: 'installations#options'



  # mount Blogit::Engine => "/blog"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
