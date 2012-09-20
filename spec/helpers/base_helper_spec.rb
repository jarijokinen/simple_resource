require "spec_helper"
require "dummy/app/controllers/languages_controller"

describe SimpleResource::BaseHelper do
  let(:language) { FactoryGirl.create(:language) }

  before :each do
    @controller = LanguagesController.new
    @controller.request = ActionDispatch::TestRequest.new
    @controller.instance_variable_set("@language", language)
  end

  describe "#resource_human_name" do
    context "when resource class is defined" do
      it "returns resource human name" do
        helper.resource_human_name("Language").should eq("Language")
      end
      
      it "returns translated resource human name" do
        set_locale
        helper.resource_human_name("Language").should eq("Kieli")
        reset_locale
      end
    end

    context "when resource class is not defined" do
      it "returns resource human name" do
        helper.resource_human_name.should eq("Language")
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
      helper.resource_title.should eq("Language #{language.id}")
    end
    
    it "returns translated resource title" do
      set_locale
      helper.resource_title.should eq("Kieli #{language.id}")
      reset_locale
    end
  end

  describe "#collection_title" do
    it "returns collection title" do
      helper.collection_title.should eq("Languages")
    end
    
    it "returns translated collection title" do
      set_locale
      helper.collection_title.should eq("Kielet")
      reset_locale
    end
  end

  describe "#new_resource_title" do
    it "returns default new resource title" do
      helper.new_resource_title.should eq("New Language")
    end

    it "returns translation for a new resource title" do
      set_locale
      helper.new_resource_title.should eq("Uusi Kieli")
      reset_locale
    end
  end

  describe "#new_resource_link" do
    it "returns default version of new resource link" do
      helper.new_resource_link.should eq('<a href="/languages/new">New Language</a>')
    end

    it "returns translated version of new resource link" do
      set_locale
      helper.new_resource_link.should eq('<a href="/languages/new">Uusi Kieli</a>')
      reset_locale
    end 
  end
  
  describe "#edit_resource_title" do
    it "returns default edit resource title" do
      helper.edit_resource_title.should eq("Edit Language")
    end

    it "returns translation for a edit resource title" do
      set_locale
      helper.edit_resource_title.should eq("Muokkaa Kieli")
      reset_locale
    end
  end

  describe "#resource_attributes" do
    it "returns resource attributes" do
      helper.resource_attributes.should == ["id", "name", "created_at", "updated_at"]
    end
  end
end
