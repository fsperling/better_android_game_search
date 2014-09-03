require 'spec_helper'

describe "GamePages" do
  subject { page }
  let!(:created_categories) { FactoryGirl.create_list(:category, 5) }

  describe "game details page" do
    let(:game) { FactoryGirl.create(:game) }
    before { visit game_path(game) }
  
    it { should have_selector('h1', text: game.name) }
    it { should have_content(game.description) }
    it { should have_content(game.categories.map(&:name).join(" ")) }
    it { should have_content(game.version) }
    it { should have_content(game.email) }
    it { should have_content(game.webpage) }
  end
  
  describe "create new game page" do
    before { visit new_game_path }

    it { should have_content('Enter information for a new game') }
    it { should have_title(full_title('Create new game')) }
    Category.all.each do |category|
      expect(page).to have_selector('label', text: category.name)
    end
  end
  
  describe "create new game" do
    before { visit new_game_path }
    
    let(:submit) { "Create new game" }

    describe "with invalid information" do
      it "should not create a game" do
        expect { click_button submit }.not_to change(Game, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example Game"
        fill_in "Description",  with: "super shooter"
        fill_in "Version",      with: "v1.1"
        fill_in "Email",        with: "abc@email.com"
        fill_in "Webpage",      with: "http://web.de"
      end

      it "should create game" do
        expect { click_button submit }.to change(Game, :count).by(1)
      end
    end
    
    describe "with valid info and categories" do
      before do
        fill_in "Name",         with: "Example Game"
        fill_in "Description",  with: "Example Desc"
        check(created_categories.first.name)
        check(created_categories.last.name)
        screenshot_and_save_page
      end
 
      it "should be assigned to category" do
        click_button submit
        Game.last.categories.include?(created_categories.first).should be_true
        Game.last.categories.include?(created_categories.last).should be_true
      end
    end
  end  
  
  describe "edit game" do
    let(:game) { FactoryGirl.create(:game) }
    
    before {
      game.assign_category!(created_categories[0]) 
      game.assign_category!(created_categories[1])
      visit edit_game_path(game) 
      }

    it { should have_selector('h1', text: 'Edit game') }
    it { should have_title(full_title('Edit game')) }

    it { should have_field('game_name', :with => game.name) }
    it { should have_field('game_description', :with => game.description) }
    it { should have_field('game_version', :with => game.version) }
    it { should have_field('game_email', :with => game.email) }
    it { should have_field('game_webpage', :with => game.webpage) }
    it { should have_button("Save changes") }

    it { should have_checked_field(created_categories[0].name) } 
    it { should have_checked_field(created_categories[1].name) }
    it { should have_unchecked_field(created_categories[2].name) }
    it { should have_unchecked_field(created_categories[3].name) }
    
    describe "change and submit details" do
      let(:new_name)  { "New Name" }
      let(:new_desc) { "new desc" }
      let(:new_version) { "new version" }
      let(:new_email) { "new@email.com" }
      let(:new_webpage) { "http://new.webpage.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Description",      with: new_desc
        fill_in "Version",          with: new_version
        fill_in "Email",            with: new_email
        fill_in "Webpage",          with: new_webpage
        check(created_categories[2].name)
        uncheck(created_categories[1].name)
        click_button "Save changes"
      end

      it { should have_selector('h1', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      
      specify { expect(game.reload.categories.map(&:name)).to eq [created_categories[0].name, created_categories[2].name] }
      specify { expect(game.reload.name).to  eq new_name }
      specify { expect(game.reload.description).to eq new_desc }
      specify { expect(game.reload.version).to eq new_version }
      specify { expect(game.reload.email).to eq new_email } 
      specify { expect(game.reload.webpage).to eq new_webpage }
    end    
  end
    
  describe "index" do
    let!(:games_list) { FactoryGirl.create_list(:game, 5) }
    before { visit games_path }

    it { should have_title('All games') }
    it { should have_content('All games') }

    it "should list each game that was created before" do
      games_list.each do |game|
        expect(page).to have_selector('li', text: game.name)
        expect(page).to have_content(game.description)
      end
    end

    it "should list each game that is in the db" do
      Game.all.each do |game|
        expect(page).to have_selector('li', text: game.name)
        expect(page).to have_content(game.description)
      end
    end
  end
  
  # other ways to check checkboxes
  #find(:xpath , '//*[@id="unique_box"]').set(true)
  #check('game_category_ids_1')
  
  #find(:css, "#game_category_ids_1[value='1']").set(true)
  #find(:css, "#game[category_ids][][value='1']").set(true)
  #find(:xpath , '//*[@id="game_category_ids_1"]').set(true)        
  
  #find(:xpath, ".//input[@id='Extrapainful[]']
  
end
