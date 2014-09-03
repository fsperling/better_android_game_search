require 'spec_helper'

describe Category do
  before do
    @category = Category.new(name: "Shooter")
  end
  subject { @category }

  it { should respond_to(:name) }

  describe "when category already exists" do
    before do
      same_category = @category.dup
      same_category.save
    end

    it { should_not be_valid }
  end

  describe "when category already exists" do
    before do
      same_category = @category.dup
      same_category.name.upcase!
      same_category.save
    end

    it { should_not be_valid }
  end

  describe "when category is not present" do
    before { @category.name = " " }
    it { should_not be_valid }
  end

  describe "when category is too long" do
    before { @category.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when list games of a category" do
    let(:g1) { Game.new(name: "Game Abc123", description: "Abc ist ein tolles Game mit") }
    let(:g2) { Game.new(name: "Game Def", description: "Def ist ein tolles Game mit") }
    before {
      @category.save
      g1.save
      g2.save
      g1.assign_category!(@category)
      g2.assign_category!(@category)
    }
    
    it do 
      expect(g1.category?(@category)).to be_true
    end
    
    it "should return all assigned games" do
      expect(@category.games).to eq([g1, g2])
    end 
  end
  
  describe "when category is created by factory girl" do
     let(:category1) { FactoryGirl.create(:category) }
     
     it "should be stored in the db" do
       expect(Category.find_by(id: category1.id)).to be_true
       expect(Category.find_by(id: category1.id).name).to eq(category1.name) 
     end
  end
end