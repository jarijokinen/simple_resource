module SimpleResource
  class BaseController < ::ApplicationController
    inherit_resources
    defaults route_prefix: ""
  end
end
