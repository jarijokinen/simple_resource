module SimpleResource
  class BaseController < ::ApplicationController
    if defined?(CanCan)
      load_and_authorize_resource

      rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_url, alert: exception.message
      end
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
