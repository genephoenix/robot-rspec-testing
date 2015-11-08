require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#heal!" do
    it "should not be able to heal when their health is 0" do
      expect(@robot).to receive(:health).and_return(0)
      expect{@robot.heal!(50)}.to raise_error(Robot::RobotAlreadyDeadError) 
    end
  end 

  describe "#attack!" do
    @item = Item.new('umbrella', 35)
    it "should only be able to attack another robot" do
      expect{@robot.attack!(@item)}.to raise_error(Robot::UnattackableEnemy)
    end
  end

end