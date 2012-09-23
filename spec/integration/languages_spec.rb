require "spec_helper"

describe "Languages" do
  describe "#index" do
    let!(:collection) { FactoryGirl.create_list(:language, 10) }

    before :each do
      visit "/languages"
    end

    it "has a correct title" do
      page.should have_xpath "//title", text: "Languages | Dummy"
    end

    it "has a correct heading" do
      page.should have_css "h1", "Languages"
    end

    it "lists all languages" do
      within "table" do
        within "thead" do
          page.should have_css "th", text: "Name"
        end
        within "tbody" do
          collection.each do |resource|
            page.should have_css "td", text: resource.name
            page.should have_link "Show", href: "/languages/#{resource.id}"
            page.should have_link "Edit", href: "/languages/#{resource.id}/edit"
            page.should have_link "Delete", href: "/languages/#{resource.id}"
          end
        end
      end
    end

    it "has a link to create a new language" do
      page.should have_link "New Language", href: "/languages/new"
    end
  end
end
