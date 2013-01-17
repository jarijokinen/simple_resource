module SimpleResource
  class UserController < SimpleResource::BaseController
    protected

    def begin_of_association_chain
      if defined?(Devise)
        current_user
      end
    end
  end
end
