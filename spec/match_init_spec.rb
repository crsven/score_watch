require 'spec_helper'
require 'fixtures'

describe "#initialize" do
  before do
    fixture = Fixtures.not_started
    @input_match_id = 555555
    WebMock.stub_request(:get, "http://soccernet.espn.go.com/gamecast?id=#{@match_id}")
    TrollopUI.stub(:parse).and_return(true)
    Match.any_instance.stub(:get_teams)
    Match.any_instance.stub(:start_match)
  end

  it "calls get_teams" do
    Match.any_instance.should_receive(:message).with(" v. ")
    @match = Match.new(555555)
  end
end
