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
      I18n.t("simple_resource.new_resource", resource_name: resource_human_name, 
        default: "New #{resource_human_name}")
    end

    def new_resource_link
      link_to(new_resource_title, new_resource_path)
    end

    def edit_resource_title
      I18n.t("simple_resource.edit_resource", resource_name: resource_human_name, 
        default: "Edit #{resource_human_name}")
    end

    def resource_attributes
      resource_class.attribute_names
    end

    def non_human_attributes
      %w(id updated_at created_at)
    end

    def resource_human_attributes
      human_attributes = resource_attributes - non_human_attributes
      if respond_to?("parent?")
        human_attributes = human_attributes - ["#{parent.class.name.underscore}_id"]
      end
      human_attributes
    end

    def attribute_human_name(attribute_name)
      attribute_name = attribute_name.to_s
      I18n.t("activerecord.attributes.#{controller_name.singularize}.#{attribute_name}",
        default: attribute_name.humanize)
    end

    def attribute_value(resource, attribute_name, truncation = 50)
      value = resource.send(attribute_name).to_s.truncate(truncation)
      if attribute_name.to_s.match(/_id$/)
        model_name = attribute_name.gsub(/_id$/, "").classify
        value = eval(model_name).find(value).to_s
      end
      value
    end

    def link_to_action(action_name, title, path)
      action_name = action_name.to_sym
      if action_name == :delete
        link_to(t("simple_resource.#{action_name.to_s}", default: title), path,
          method: :delete, confirm: t("simple_resource.delete_confirmation", default: "Are you sure?"))
      else
        link_to(t("simple_resource.#{action_name.to_s}", default: title), path)
      end
    end

    def default_actions_for(resource)
      html = Array.new
      html << link_to_action(:show, "Show", resource_path(resource))
      html << link_to_action(:edit, "Edit", edit_resource_path(resource))
      html << link_to_action(:delete, "Delete", resource_path(resource))
      html.join("\n").html_safe
    end

    def controller_namespaces
      namespaces = controller_path.split("/")
      namespaces.pop
      namespaces
    end

    def resource_form_path
      if controller_namespaces.empty?
        if !resource.new_record?
          resource_path
        else
          collection_path
        end
      else
        controller_namespaces | [resource]
      end
    end
  end
end
