require 'spec_helper'

describe "GamePages" do
  subject { page }

  describe "game details page" do
    let(:game) { FactoryGirl.create(:game) }
    before { visit game_path(game) }
  
    it { should have_selector('h1', text: game.name) }
    it { should have_content(game.description) }
   # it { should have_content(game.categories) }
  end
  
  describe "create new game page" do
    before { visit new_game_path }

    it { should have_content('Enter information for a new game') }
    it { should have_title(full_title('Create new game')) }
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
      end

      it "should create game" do
        expect { click_button submit }.to change(Game, :count).by(1)
      end
    end
  end  
  
  describe "index" do
    before do
      
      FactoryGirl.create(:game)
      FactoryGirl.create(:game, name: "Bob", description: "describidid")
      FactoryGirl.create(:game, name: "Ben", description: "more idid")
      visit games_path
    end

    it { should have_title('All games') }
    it { should have_content('All games') }

    it "should list each game" do
      Game.all.each do |game|
        expect(page).to have_selector('li', text: game.name)
        expect(page).to have_content(game.description)
      end
    end
  end
  
end
