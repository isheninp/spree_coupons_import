Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    get 'coupons_import/new', to: 'coupons_import#new', as: 'coupons_import_new'
    post 'coupons_import', to: 'coupons_import#create', as: 'coupons_imports'
  end
end
