module SimpleResource
  module BaseHelper
    def resource_human_name(resource_class_name = nil)
      if resource_class_name
        eval("#{resource_class_name}.model_name.human")
      else
        resource_class.model_name.human
      end
    end

    def resource_title
      "#{resource_human_name} #{resource.id}"
    end
  end
end
