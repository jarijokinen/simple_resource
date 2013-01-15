# -*- encoding: utf-8 -*-
require "spec_helper"

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

  describe "#non_human_attributes" do
    it "returns non human attributes" do
      helper.non_human_attributes == ["id", "created_at", "updated_at"]
    end
  end
  
  describe "#resource_human_attributes" do
    context "when resource doesn't have a parent resource" do
      it "returns resource human attributes" do
        helper.resource_human_attributes.should == ["name"]
      end
    end

    context "when resource has a parent resource" do
      before :each do
        category = FactoryGirl.create(:category)
        post = FactoryGirl.create(:post, category: category)
        @controller = PostsController.new
        @controller.request = ActionDispatch::TestRequest.new
        @controller.instance_variable_set("@category", category)
        @controller.instance_variable_set("@post", post)
      end

      it "returns resource human attributes" do
        helper.resource_human_attributes.should == ["language_id", "title", "content"]
      end
    end
  end

  describe "#attribute_human_name" do
    it "returns attribute human name" do
      helper.attribute_human_name(:name).should eq("Name")
      helper.attribute_human_name(:created_at).should eq("Created at")
    end

    it "returns translated attribute numan name" do
      set_locale
      helper.attribute_human_name(:name).should eq("Nimi")
      helper.attribute_human_name(:created_at).should eq("Created at")
      reset_locale
    end

    it "accepts attribute name as Symbol" do
      helper.attribute_human_name(:name).should eq("Name")
    end

    it "accepts attribute name as String" do
      helper.attribute_human_name("name").should eq("Name")
    end
  end

  describe "#attribute_value" do
    context "when attribute value is short" do
      it "returns attribute value without truncation" do
        helper.attribute_value(language, :name).should eq(language.name)
      end
    end

    context "when attribute value is long" do
      before :each do
        @resource = FactoryGirl.create(:language)
        @resource.name = Forgery(:lorem_ipsum).words(100)
      end

      it "returns truncated attribute value" do
        expected = @resource.name.truncate(50)
        helper.attribute_value(@resource, :name).should eq(expected)
      end
    end
  end

  describe "#link_to_action" do
    context "with action :show" do
      it "returns show link" do
        helper.link_to_action(:show, "Show", "/languages/1").should eq('<a href="/languages/1">Show</a>')
      end
      
      it "returns translated show link" do
        set_locale
        helper.link_to_action(:show, "Näytä", "/languages/1").should eq('<a href="/languages/1">Näytä</a>')
        reset_locale
      end
    end
    
    context "with action :edit" do
      it "returns edit link" do
        helper.link_to_action(:edit, "Edit", "/languages/1/edit").should eq('<a href="/languages/1/edit">Edit</a>')
      end
      
      it "returns translated edit link" do
        set_locale
        helper.link_to_action(:edit, "Muokkaa", "/languages/1/edit").should eq('<a href="/languages/1/edit">Muokkaa</a>')
        reset_locale
      end
    end
    
    context "with action :delete" do
      it "returns delete link" do
        helper.link_to_action(:delete, "Delete", "/languages/1").should eq('<a href="/languages/1" data-confirm="Are you sure?" data-method="delete" rel="nofollow">Delete</a>')
      end
      
      it "returns translated delete link" do
        set_locale
        helper.link_to_action(:delete, "Poista", "/languages/1").should eq('<a href="/languages/1" data-confirm="Oletko varma?" data-method="delete" rel="nofollow">Poista</a>')
        reset_locale
      end
    end
    
    context "with custom action" do
      it "returns link to custom action" do
        helper.link_to_action(:children, "Children", "/languages/1/children").should eq('<a href="/languages/1/children">Children</a>')
      end
    end
  end

  describe "#default_actions_for" do
    let(:collection) { FactoryGirl.create_list(:language, 10) }

    it "returns default actions for given resource" do
      collection.each do |resource|
        expected =  %Q(<a href="/languages/#{resource.id}">Show</a>\n)
        expected += %Q(<a href="/languages/#{resource.id}/edit">Edit</a>\n)
        expected += %Q(<a href="/languages/#{resource.id}" data-confirm="Are you sure?")
        expected += %Q( data-method="delete" rel="nofollow">Delete</a>)
        helper.default_actions_for(resource).should eq(expected)
      end
    end
  end

  describe "#controller_namespaces" do
    context "when no namespaces exist" do
      it "returns an empty array" do
        helper.controller_namespaces.should be_empty
      end
    end

    context "when namespace exists" do
      before :each do
        @controller = Backend::LanguagesController.new
        @controller.request = ActionDispatch::TestRequest.new
        @controller.instance_variable_set("@language", language)
      end

      it "returns namespace in array" do
        helper.controller_namespaces.should == ["backend"]
      end
    end
  end

  describe "#resource_form_path" do
    describe "new action" do
      before :each do
        @controller = LanguagesController.new
        @controller.request = ActionDispatch::TestRequest.new
        @controller.request.action = "new"
        @controller.instance_variable_set("@language", Language.new)
      end

      context "when no namespaces exist" do
        it "returns path without namespace" do
          helper.resource_form_path.should eq("/languages")
        end
      end

      context "when namespace exists" do
        before :each do
          @controller = Backend::LanguagesController.new
          @controller.request = ActionDispatch::TestRequest.new
          @controller.request.action = "new"
          @language = Language.new
          @controller.instance_variable_set("@language", @language)
        end

        it "returns path with namespace" do
          helper.resource_form_path.should == ["backend", @language]
        end
      end
    end
    
    describe "edit action" do
      before :each do
        @controller = LanguagesController.new
        @controller.request = ActionDispatch::TestRequest.new
        @controller.request.action = "edit"
        @controller.instance_variable_set("@language", language)
      end

      context "when no namespaces exist" do
        it "returns path without namespace" do
          helper.resource_form_path.should eq("/languages/#{language.id}")
        end
      end

      context "when namespace exists" do
        before :each do
          @controller = Backend::LanguagesController.new
          @controller.request = ActionDispatch::TestRequest.new
          @controller.request.action = "edit"
          @controller.instance_variable_set("@language", language)
        end

        it "returns path with namespace" do
          helper.resource_form_path.should == ["backend", language]
        end
      end
    end
  end

  describe "#render_actions_for" do
    let(:collection) { FactoryGirl.create_list(:language, 10) }

    it "returns actions for given resource in HTML" do
      collection.each do |resource|
        expected =  %Q(<a href="/languages/#{resource.id}">Show</a>\n)
        expected += %Q(<a href="/languages/#{resource.id}/edit">Edit</a>\n)
        expected += %Q(<a href="/languages/#{resource.id}" data-confirm="Are you sure?")
        expected += %Q( data-method="delete" rel="nofollow">Delete</a>\n)
        helper.render_actions_for(resource).should eq(expected)
      end
    end
  end

  describe "#render_collection_table" do
    before :each do
      Language.destroy_all
    end

    let(:collection) { FactoryGirl.create_list(:language, 10) }

    it "returns collection table in HTML" do
      expected =  %Q(<table>)
      expected += %Q(<thead><tr><th>Name</th><th>&nbsp;</th></tr></thead><tbody>)

      collection.each do |resource|
        expected += %Q(<tr><td>#{resource.name}</td><td class="actions">)
        expected += %Q(<a href="/languages/#{resource.id}">Show</a>)
        expected += %Q(<a href="/languages/#{resource.id}/edit">Edit</a>)
        expected += %Q(<a href="/languages/#{resource.id}" data-confirm="Are you sure?")
        expected += %Q( data-method="delete" rel="nofollow">Delete</a>)
        expected += %Q(</td></tr>)
      end

      expected += %Q(</tbody></table>)
      helper.render_collection_table.gsub(/\n */, "").should eq(expected)
    end
  end

  describe "#render_form" do
    describe "new action" do
      before :each do
        @controller = LanguagesController.new
        @controller.request = ActionDispatch::TestRequest.new
        @controller.request.action = "new"
        @language = Language.new
        @controller.instance_variable_set("@language", @language)
      end

      context "with formtastic (default) builder" do
        it "returns form" do
          expected = <<-END
            <form accept-charset="UTF-8" action="/languages" class="formtastic language" 
              id="new_language" method="post" novalidate="novalidate">
              <div style="margin:0;padding:0;display:inline">
                <input name="utf8" type="hidden" value="&#x2713;" />
              </div>
              <fieldset class="inputs">
                <ol>
                  <li class="string input required stringish" id="language_name_input">
                    <label class=" label" for="language_name">Name<abbr title="required">*</abbr></label>
                    <input id="language_name" maxlength="255" name="language[name]" type="text" />
                  </li>
                </ol>
              </fieldset>
              <fieldset class="actions">
                <ol>
                  <li class="action input_action " id="language_submit_action">
                    <input name="commit" type="submit" value="Create Language" />
                  </li>
                  <li class="action link_action " id="language_cancel_action">
                    <a href="/languages">Cancel</a>
                  </li>
                </ol>
              </fieldset>
            </form>
          END
          helper.render_form.gsub(/\n */, "").should eq(expected.gsub(/(\n|^ +)/, ""))
        end
      end
    end
    
    describe "edit action" do
      before :each do
        @controller = LanguagesController.new
        @controller.request = ActionDispatch::TestRequest.new
        @controller.request.action = "edit"
        @controller.instance_variable_set("@language", language)
      end

      context "with formtastic (default) builder" do
        it "returns form" do
          expected = <<-END
            <form accept-charset="UTF-8" action="/languages/#{language.id}" class="formtastic language" 
              id="edit_language_#{language.id}" method="post" novalidate="novalidate">
              <div style="margin:0;padding:0;display:inline">
                <input name="utf8" type="hidden" value="&#x2713;" />
                <input name="_method" type="hidden" value="put" />
              </div>
              <fieldset class="inputs">
                <ol>
                  <li class="string input required stringish" id="language_name_input">
                    <label class=" label" for="language_name">Name<abbr title="required">*</abbr></label>
                    <input id="language_name" maxlength="255" name="language[name]" type="text" 
                      value="#{language.name}" />
                  </li>
                </ol>
              </fieldset>
              <fieldset class="actions">
                <ol>
                  <li class="action input_action " id="language_submit_action">
                    <input name="commit" type="submit" value="Update Language" />
                  </li>
                  <li class="action link_action " id="language_cancel_action">
                    <a href="/languages">Cancel</a>
                  </li>
                </ol>
              </fieldset>
            </form>
          END
          helper.render_form.gsub(/\n */, "").should eq(expected.gsub(/(\n|^ +)/, ""))
        end
      end
    end
  end
end
