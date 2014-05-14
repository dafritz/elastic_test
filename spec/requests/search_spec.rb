require 'spec_helper'

describe "SearchData" do
  before(:each) do
    [SearchData].each do |klass|

      # make sure that the current model is using tire
      if klass.respond_to? :tire
        # delete the index for the current model
        klass.tire.index.delete

        # the mapping definition must get executed again. for that, we reload the model class.
        load File.expand_path("../../../app/models/search_data.rb", __FILE__)

      end
    end
    SearchData.delete_all
    create(:search_data, :record_name => "Record 1", :record_body => 'Body 1')
    create(:search_data, :record_name => "Record 2", :record_body => 'Body 2')
    create(:search_data, :record_name => "Record 3", :record_body => 'Body 3')
    SearchData.tire.index.refresh
  end
  
  
  describe "search field submit" do

    it "returns a single result from title" do

       visit root_path
       fill_in "search_field", :with => "1"
       click_button "search"
       page.should have_content("1 Result")
       page.should have_content("Record 1")
    end
    
    it "returns a single result from body" do
      visit root_path
      fill_in "search_field", :with => "2"
      click_button "search"
      page.should have_content("1 Result")
      page.should have_content("Body 2")
    end
  end
    
  describe "search all" do

    it "returns all results by default" do

      visit root_path
      page.should have_content("3 Results")
    end
  end

  describe "clear all" do
    it "returns no results after bad search the clears results" do 
      visit root_path
      fill_in "search_field", :with => "test for none"
      click_button "search"
      page.should have_content("0 Results")
      page.should have_content("Clear Search")
      click_link("Clear Search")
      page.should have_content("3 Results")
      
    end    
    
  end
end
