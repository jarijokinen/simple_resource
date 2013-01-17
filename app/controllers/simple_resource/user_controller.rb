module SimpleResource
  class UserController < SimpleResource::BaseController
    if defined?(Devise)
      before_filter :authenticate_user!
    end

    protected

    def begin_of_association_chain
      if defined?(Devise)
        current_user
      end
    end
  end
end
