require 'spec_helper'

describe Game do

  before do
    @game = Game.new(name: "Unreal", description: "super shooter")
  end
  subject { @game }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:version) }
  it { should respond_to(:email) }
  it { should respond_to(:webpage) }
  it { should respond_to(:game_categorizations) }
  it { should respond_to(:categories) }
  it { should respond_to(:assign_category!) }
  it { should respond_to(:category?) }
  it { should respond_to(:remove_from_category!) }
  it { should respond_to(:banner_icon_url) }
  it { should respond_to(:banner_image_url) }
  it { should respond_to(:screenshots) }
  

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

  describe "when version is too long" do
    before { @game.version = "a" * 31 }
    it { should_not be_valid }
  end
  
  describe "when email is too long" do
    before { @game.email = "a" * 101 }
    it { should_not be_valid }
  end
  
  describe "when webpage is too long" do
    before { @game.webpage = "http://" + "a" * 101 }
    it { should_not be_valid }
  end

  describe "when banner_icon_url is too long" do
    before { @game.banner_icon_url = "a" * 301 }
    it { should_not be_valid }
  end

  describe "when banner_image_url is too long" do
    before { @game.banner_image_url = "a" * 301 }
    it { should_not be_valid }
  end

  describe "when webpage is too long" do
    before { @game.webpage = "a" * 101 }
    it { should_not be_valid }
  end
  
  describe "when assigning a value to webpage" do
    before { @game.webpage = "http://random.com/abc"}
    it "should only accept urls" do
      expect(only_urls_are_accepted(@game.webpage, @game)).to be_true
    end
  end

  describe "when assigning a value to banner_icon_url" do
    before { @game.banner_icon_url = "http://random.com/abc"}
    it "should only accept urls" do
      expect(only_urls_are_accepted(@game.banner_icon_url, @game)).to be_true
    end
  end  

  describe "when assigning a value to banner_image_url" do
    before { @game.banner_image_url = "http://random.com/abc"}
    it "should only accept urls" do
      expect(only_urls_are_accepted(@game.banner_image_url, @game)).to be_true
    end
  end  

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
      foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @game.email = invalid_address
        expect(@game).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @game.email = valid_address
        expect(@game).to be_valid
      end
    end
  end
  
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @game.email = mixed_case_email
      @game.save
      expect(@game.reload.email).to eq mixed_case_email.downcase
    end
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
  
  describe "screenshot associations" do

    before { @game.save }
    let!(:screenshot1) { FactoryGirl.create(:screenshot, game: @game) }
    let!(:screenshot2) { FactoryGirl.create(:screenshot, game: @game) }

    it "should have the right screenshots" do
      expect(@game.screenshots.to_a).to eq [screenshot1, screenshot2]
    end
  
    it "should destroy associated screenshots" do
      screenshots = @game.screenshots.to_a
      @game.destroy
      expect(screenshots).not_to be_empty
      screenshots.each do |screenshot|
        expect(Screenshot.where(id: screenshot.id)).to be_empty
      end
    end  
  end
  
end
