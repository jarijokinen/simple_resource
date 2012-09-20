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

    def collection_title
      I18n.t("activerecord.models.#{controller_name.singularize}.other",
        default: controller_name.humanize)
    end

    def new_resource_title
      I18n.t("simple_resource.new", resource_name: resource_human_name, 
        default: "New #{resource_human_name}")
    end

    def new_resource_link
      link_to(new_resource_title, new_resource_path)
    end

    def edit_resource_title
      I18n.t("simple_resource.edit", resource_name: resource_human_name, 
        default: "Edit #{resource_human_name}")
    end
  end
end
