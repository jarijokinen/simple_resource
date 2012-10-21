module SimpleResource
  class BaseController < ::ApplicationController
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
