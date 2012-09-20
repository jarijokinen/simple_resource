require "spec_helper"
require "dummy/app/controllers/locales_controller"

describe SimpleResource::BaseHelper do
  let(:locale) { FactoryGirl.create(:locale) }

  before :each do
    @controller = LocalesController.new
    @controller.request = ActionDispatch::TestRequest.new
    @controller.instance_variable_set("@locale", locale)
  end

  describe "#resource_human_name" do
    context "when resource class is defined" do
      it "returns resource human name" do
        helper.resource_human_name("Locale").should eq("Locale")
      end
      
      it "returns translated resource human name" do
        set_locale
        helper.resource_human_name("Locale").should eq("Kieli")
        reset_locale
      end
    end

    context "when resource class is not defined" do
      it "returns resource human name" do
        helper.resource_human_name.should eq("Locale")
      end
      
      it "returns translated resource human name" do
        set_locale
        helper.resource_human_name.should eq("Kieli")
        reset_locale
      end
    end
  end

  describe "#resource_title" do
    it "returns resource title" do
      helper.resource_title.should eq("Locale #{locale.id}")
    end
    
    it "returns translated resource title" do
      set_locale
      helper.resource_title.should eq("Kieli #{locale.id}")
      reset_locale
    end
  end

  describe "#collection_title" do
    it "returns collection title" do
      helper.collection_title.should eq("Locales")
    end
    
    it "returns translated collection title" do
      set_locale
      helper.collection_title.should eq("Kielet")
      reset_locale
    end
  end

  describe "#new_resource_title" do
    it "returns default new resource title" do
      helper.new_resource_title.should eq("New Locale")
    end

    it "returns translation for a new resource title" do
      set_locale
      helper.new_resource_title.should eq("Uusi Kieli")
      reset_locale
    end
  end

  describe "#new_resource_link" do
    it "returns default version of new resource link" do
      helper.new_resource_link.should eq('<a href="/locales/new">New Locale</a>')
    end

    it "returns translated version of new resource link" do
      set_locale
      helper.new_resource_link.should eq('<a href="/locales/new">Uusi Kieli</a>')
      reset_locale
    end 
  end
end
