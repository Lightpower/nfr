# encoding: UTF-8
require "spec_helper"

describe CodeString do

  context 'downcase code' do
    before :each do
      zone = FactoryGirl.create(:zone)
      task = FactoryGirl.create(:task, zone: zone)
      @code = FactoryGirl.create(:code, task: task)
    end
    it 'success' do
      data = 'ABCАБВ'
      @code_string = FactoryGirl.create(:code_string, code: @code, data: data)
      @code_string.reload

      @code_string.data.should == data.downcase
    end
  end
end