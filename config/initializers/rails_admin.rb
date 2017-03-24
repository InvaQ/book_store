RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
   config.authenticate_with do
     warden.authenticate! scope: :user
   end
   config.current_user_method(&:current_user)

  ## == Cancan ==
   config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true
  config.parent_controller = 'ApplicationController'

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    state

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Order' do
    list do
      fields :id, :created_at
      field :state, :state
    end
    

    state({ states: {
      complete: 'btn-info',
      in_transit: 'btn-primary',
      delivered: 'btn-success',
      canceled: 'btn-danger' } })
  end


  config.model 'Review' do
    list do
      fields :title, :description, :book, :created_at, :user
      field :state, :state
      field :verified
    end

    show do
      fields :title, :description, :book, :created_at, :user, :state, :verified
    end

    edit do
      field :state, :enum do
        enum_method do
          :assm_states
        end
      end
    end

    state({
      states: {
        unchecked: 'btn-warning',
        rejected: 'btn-danger',
        approved: 'btn-success' },
      events: {
        approve: 'btn-success',
        reject: 'btn-danger' }
    })
  end
end
