require "spec_helper"

describe Code do

  context 'by_order' do
    before :each do
      zone = FactoryGirl.create(:zone)
      @task = FactoryGirl.create(:task, zone: zone)
      [4, 2, 7, 9, 10, 1, 5, 3, 6, 8].map { |n| FactoryGirl.create(:code, task: @task, number: n)}.each do |code|
        FactoryGirl.create(:code_string, code: code)
      end
    end

    it 'success' do
      @task.codes.by_order.map(&:number).should ==  @task.codes.map(&:number).sort
    end
  end

  context 'zone' do
    before :each do
      @zones = [FactoryGirl.create(:zone), FactoryGirl.create(:zone)]
      task = FactoryGirl.create(:task, zone: @zones.first)
      free_task = FactoryGirl.create(:task, zone: nil)

      @zone_access_code = FactoryGirl.create(:code, task: nil)
      FactoryGirl.create(:code_string, code: @zone_access_code)
      @zone_access_code.reload
      @zones.last.access_code = @zone_access_code
      @zones.last.save

      @code = FactoryGirl.create(:code, task: task)
      FactoryGirl.create(:code_string, code: @code)
      @code.reload

      @free_code = FactoryGirl.create(:code, task: free_task)
      FactoryGirl.create(:code_string, code: @zone_access_code)
      @free_code.reload
    end

    it 'success' do
      @zone_access_code.zone.should == @zones.last
      @code.zone.should == @zones.first
      @free_code.zone.should be_blank
    end
  end

  context 'show_code' do
    before :each do
      zone = FactoryGirl.create(:zone)
      task = FactoryGirl.create(:task, zone: zone)

      @code = FactoryGirl.create(:code, task: task)
      @code_string = FactoryGirl.create(:code_string, code: @code)
      @code.reload

      @code_name = 'DR12345'
      @named_code = FactoryGirl.create(:code, task: task, name: @code_name)
      FactoryGirl.create(:code_string, code: @named_code)
      @code.reload
    end

    it 'success' do
      @code.show_code.should == @code_string.data
      @named_code.show_code.should == @code_name
    end
  end

end