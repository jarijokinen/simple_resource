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
    end

    context "when resource class is not defined" do
      it "returns resource human name" do
        helper.resource_human_name.should eq("Locale")
      end
    end
  end

  describe "#resource_title" do
    it "returns resource title" do
      helper.resource_title.should eq("Locale #{locale.id}")
    end
  end

  describe "#collection_title" do
    it "returns collection title" do
      helper.collection_title.should eq("Locales")
    end
  end

  describe "#new_resource_title" do
    context "when I18n.locale is set" do
      before :each do
        I18n.locale = "fi"
      end

      after :each do
        I18n.locale = I18n.default_locale
      end

      it "returns translation for a new resource title" do
        helper.new_resource_title.should eq("Uusi Kieli")
      end
    end

    context "when I18n.locale is not set" do
      it "returns default new resource title" do
        helper.new_resource_title.should eq("New Locale")
      end
    end
  end

  describe "#new_resource_link" do
    context "when I18n.locale is set" do
      before :each do
        I18n.locale = "fi"
      end

      after :each do
        I18n.locale = I18n.default_locale
      end

      it "returns localized version of new resource link" do
        helper.new_resource_link.should eq('<a href="/locales/new">Uusi Kieli</a>')
      end
    end

    context "when I18n.locale is not set" do
      it "returns default version of new resource link" do
        helper.new_resource_link.should eq('<a href="/locales/new">New Locale</a>')
      end
    end
  end
end
