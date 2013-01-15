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
      t("activerecord.models.#{controller_name.singularize}.other",
        default: controller_name.humanize)
    end

    def new_resource_title
      t("simple_resource.titles.new_resource", resource_name: resource_human_name)
    end
    
    def new_resource_link_title
      t("simple_resource.links.new_resource", resource_name: resource_human_name)
    end

    def new_resource_link
      link_to(icon_for(:new) + new_resource_link_title, new_resource_path, class: button_classes_for(:new))
    end

    def edit_resource_title
      t("simple_resource.titles.edit_resource", resource_name: resource_human_name)
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
      t("activerecord.attributes.#{controller_name.singularize}.#{attribute_name}",
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
        link_to(icon_for(action_name) + t("simple_resource.#{action_name.to_s}", default: title), path, class: button_classes_for(action_name, true),
          method: :delete, confirm: t("simple_resource.messages.delete_confirmation"))
      else
        link_to(icon_for(action_name) + t("simple_resource.#{action_name.to_s}", default: title), path, class: button_classes_for(action_name, true))
      end
    end

    def default_actions_for(resource)
      html = Array.new
      html << link_to_action(:show, t("simple_resource.links.show"), resource_path(resource))
      html << link_to_action(:edit, t("simple_resource.links.edit"), edit_resource_path(resource))
      html << link_to_action(:delete, t("simple_resource.links.delete"), resource_path(resource))
      html.join("\n").html_safe
    end

    def icon_for(action)
      icon_classes = Array.new
      icon_classes << SimpleResource::Configuration.icon_classes
      icon_classes << SimpleResource::Configuration.send("icon_classes_for_#{action.to_s}")
      content_tag(:i, "", class: icon_classes.join(" ").strip).html_safe + " "
    end
    
    def button_classes_for(action, mini = false)
      button_classes = Array.new
      button_classes << SimpleResource::Configuration.button_classes
      button_classes << SimpleResource::Configuration.mini_button_classes if mini
      button_classes << SimpleResource::Configuration.send("button_classes_for_#{action.to_s}")
      button_classes.join(" ").strip
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

    def render_actions_for(resource)
      render "actions", resource: resource
    end

    def render_collection_table(custom_attributes = nil)
      render "collection",
        collection: collection,
        attributes: custom_attributes || resource_human_attributes
    end

    def render_form(form_builder = "formtastic")
      fields = resource_human_attributes
      fields.map! do |arg|
        arg.to_s.sub("_id", "").to_sym
      end
      render "simple_resource/builders/#{form_builder}", fields: fields
    end
  end
end
