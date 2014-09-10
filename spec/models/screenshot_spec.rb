require 'spec_helper'

describe Screenshot do
  let(:game) { FactoryGirl.create(:game) }
  before { @screenshot = game.screenshots.build(url: "http://imgur.com/abcd") }

  subject { @screenshot }

  it { should respond_to(:url) }
  it { should respond_to(:game_id) }
  it { should respond_to(:game) }
  its(:game) { should eq game }
    
  it { should be_valid }

# disabled because validation is deactivated because of the issue with the accepts_nested_attributes_for in the game model
#  describe "when game_id is not present" do
#    before { @screenshot.game_id = nil }
#    it { should_not be_valid }
#  end

  describe "with blank url" do
    before { @screenshot.url = " " }
    it { should_not be_valid }
  end

  describe "with url that is too long" do
    before { @screenshot.url = "a" * 301 }
    it { should_not be_valid }
  end  
  
  describe "when assigning a value to url" do
    before { @screenshot.url = "http://random.com/abc"}
    it "should only accept urls" do
      expect(only_urls_are_accepted(@screenshot.url, @screenshot)).to be_true
    end
  end
   
end
