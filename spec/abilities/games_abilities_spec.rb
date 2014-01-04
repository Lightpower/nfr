require 'spec_helper'
require 'cancan/matchers'

describe 'Game ability' do

  let(:subject) { Ability.new(@user) }
  let(:game)    { FactoryGirl.create(:game, is_visible: true, is_active: true) }

  describe 'Guest' do

    before do
      @user = nil
    end

    context 'Game' do
      context 'visible' do

        it { should     be_able_to(:read, game) }
        it { should_not be_able_to(:play, game) }
        it { should_not be_able_to(:stat, game) }
        it { should_not be_able_to(:log,  game) }

        it { should_not be_able_to(:create, game) }
        it { should_not be_able_to(:update, game) }
        it { should_not be_able_to(:delete, game) }
      end

      context 'invisible' do
        before do
          game.is_visible = false
        end

        it { should_not be_able_to(:read, game) }
        it { should_not be_able_to(:play, game) }
        it { should_not be_able_to(:stat, game) }
        it { should_not be_able_to(:log,  game) }

        it { should_not be_able_to(:create, game) }
        it { should_not be_able_to(:update, game) }
        it { should_not be_able_to(:delete, game) }
      end
    end
  end

  describe 'User' do

  end
end
