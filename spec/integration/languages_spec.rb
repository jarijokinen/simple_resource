require "spec_helper"

describe "Languages resource" do
  let!(:collection) { FactoryGirl.create_list(:language, 10) }
  
  before :each do
    visit "/languages"
  end

  describe "index" do
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

  describe "creating a new language" do
    let(:resource) { FactoryGirl.build(:language) }

    before :each do
      click_link "New Language"
    end
    
    it "has a correct title" do
      page.should have_xpath "//title", text: "New Language | Dummy"
    end

    it "has a correct heading" do
      page.should have_css "h1", "New Language"
    end

    it "has a name field" do
      page.should have_field "Name"
    end

    it "has a create language button" do
      page.should have_button "Create Language"
    end

    it "has a cancel link" do
      page.should have_link "Cancel", href: "/languages"
    end

    context "with correct values" do
      before :each do
        fill_in "Name", with: resource.name
        click_button "Create Language"
      end

      it "redirects to languages index" do
        page.current_path.should == "/languages"
      end
    end
  end
end
