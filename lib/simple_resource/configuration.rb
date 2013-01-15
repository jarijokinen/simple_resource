module SimpleResource
  module Configuration
    mattr_accessor :button_classes
    self.button_classes = "btn"
    
    mattr_accessor :mini_button_classes
    self.mini_button_classes = "btn-mini"

    mattr_accessor :button_classes_for_new
    self.button_classes_for_new = ""
    
    mattr_accessor :button_classes_for_show
    self.button_classes_for_show = ""
    
    mattr_accessor :button_classes_for_edit
    self.button_classes_for_edit = ""
    
    mattr_accessor :button_classes_for_trash
    self.button_classes_for_trash = "btn-danger"

    mattr_accessor :icon_classes
    self.icon_classes = ""
    
    mattr_accessor :icon_classes_for_new
    self.icon_classes_for_new = "icon-plus-sign"
    
    mattr_accessor :icon_classes_for_show
    self.icon_classes_for_show = "icon-zoom-in"
    
    mattr_accessor :icon_classes_for_edit
    self.icon_classes_for_edit = "icon-edit"
    
    mattr_accessor :icon_classes_for_delete
    self.icon_classes_for_delete = "icon-trash icon-white"

    def configure
      yield self if block_given?
    end
  end
end
