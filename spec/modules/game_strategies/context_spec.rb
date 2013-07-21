# encoding: UTF-8
require 'spec_helper'

describe GameStrategy::Context do

  context 'Implement Actions methods' do
    it { described_class.should be_respond_to(:send_code) }
    it { described_class.should be_respond_to(:get_hint) }
    it { described_class.should be_respond_to(:get_code_by_action_bonus) }
    it { described_class.should be_respond_to(:attach_unzoned_codes) }
  end

  context 'Implement Rendering methods' do
    it { described_class.should be_respond_to(:main_block) }
    it { described_class.should be_respond_to(:free_codes) }
  end

  context 'Implement ActionPanel methods' do
    #it { described_class.should be_respond_to(:send_code) }
  end

  describe 'Call right strategy`s method' do
    before :each do
      game = FactoryGirl.create(:game, game_type: 'test_game_type')
      code_string = "test code"
      user = FactoryGirl.create(:user)
      #  make hash with all possible required action params
      @action_params = {game: game, user: user, code_string: code_string, task_id: '1', bonus_id: '1', code_id: '1', codes: {a: '1'}}
      @rendering_params = {game_type: 'test_game_type', data: {foo: :bar}}


      module GameStrategy; class TestGameType; end end
    end

    # for each Actions method
    %w(send_code get_hint get_code_by_action_bonus attach_unzoned_codes).each do |method|
      it "calls TestGameType.#{method}(params)" do
        GameStrategy::TestGameType.stub(method.to_sym).with( @action_params ) { 'ok' }

        described_class.send(method.to_sym, @action_params).should == 'ok'
      end
    end

    # for each Rendering method
    %w(main_block free_codes stat_block logs_block logs_result mobile_block).each do |method|
      it "calls TestGameType.#{method}(params)" do
        GameStrategy::TestGameType.stub(method.to_sym).with(@rendering_params.except(:game_type)) { 'ok' }

        described_class.send(method.to_sym, @rendering_params).should == 'ok'
      end
    end
  end


end