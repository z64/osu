require "./spec_helper"

describe Osu do
  # TODO: Write tests

  it "initializes" do
    client = Osu::Client.new ENV["OSU_API_KEY"]
    client.should be_truthy
  end
end
