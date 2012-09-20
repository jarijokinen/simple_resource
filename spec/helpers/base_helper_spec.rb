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
end
