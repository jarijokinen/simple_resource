module SimpleResource
  class UserController < SimpleResource::BaseController
    protected
  
    def begin_of_association_chain
      if defined?(Devise)
        current_user
      else
        nil
      end
    end
  end
end
