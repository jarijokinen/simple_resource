module SimpleResource
  class BaseController < ::ApplicationController
    if defined?(CanCan)
      load_and_authorize_resource

      rescue_from CanCan::AccessDenied do |exception|
        if !current_user && respond_to?(:new_user_session_url)
          redirect_to new_user_session_url, alert: exception.message
        else
          redirect_to root_url, alert: exception.message
        end
      end
    end
    
    if defined?(Devise)
      before_filter :authenticate_user!
    end

    inherit_resources
    defaults route_prefix: ""

    def create
      create! { collection_url }
    end
        
    def update
      update! { collection_url }
    end
  end
end
