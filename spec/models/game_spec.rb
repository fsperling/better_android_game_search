require 'spec_helper'

describe Game do

  before do
    @game = Game.new(name: "Game Abc123", description: "Abc ist ein tolles Game mit")
  end
  subject { @game }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:game_categorizations) }
  it { should respond_to(:categories) }
  it { should respond_to(:assign_category!) }
  it { should respond_to(:category?) }
  it { should respond_to(:remove_from_category!) }
  

  describe "when name is not present" do
    before { @game.name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @game.description = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @game.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when category is assigned" do
    @game = Game.new(name: "Abc345", description: "Abc ist ein tolles Game mit")
    let(:categoryA) { Category.new(name: "Ego-Shooter567") }
    
    before {
      @game.save
      categoryA.save
      @game.assign_category!(categoryA)
    }
    
    it { should be_category(categoryA) }
    
    describe "category removed" do
      before { @game.remove_from_category!(categoryA) }
    
      it { should_not be_category(categoryA) }
    end
  
    describe "when multiple categories are assigned" do
      let(:categoryB) { Category.new(name: "Puzzle2321") }
      let(:categoryC) { Category.new(name: "Multiplayer46345") }
    
      before {
        categoryB.save!
        categoryC.save!     
        @game.assign_category!(categoryB)
        @game.assign_category!(categoryC)
      }
    
      it "should belong into all those categories" do
        expect(@game.categories.to_a).to eq [categoryA, categoryB, categoryC]
      end
      

      describe "when category is removed" do
       before {
          @game.remove_from_category!(categoryB)
          @game.remove_from_category!(categoryC)
        }
        
        it { should_not be_category(categoryB) }
        it { should_not be_category(categoryC) }
      end
    end

  end
end
