require "spec_helper"
require "dummy/app/controllers/locales_controller"

describe SimpleResource::BaseHelper do
  before :each do
    @controller = LocalesController.new
    @controller.request = ActionDispatch::TestRequest.new
    @controller.instance_variable_set("@locale", FactoryGirl.create(:locale))
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
end
