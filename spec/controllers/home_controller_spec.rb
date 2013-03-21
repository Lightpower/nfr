require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  pending describe "PUT 'input'" do
    it "returns http success" do
      put 'input'
      response.should be_success
    end
  end
end
