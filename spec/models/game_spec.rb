require "spec_helper"

describe Game do

  context 'teams' do
    before :each do
      @game = FactoryGirl.create(:game)
      @teams = 3.times.map { FactoryGirl.create(:team) }
      @other_teams = 3.times.map { FactoryGirl.create(:team) }
      @teams.each { |team| FactoryGirl.create(:game_request, game: @game, team: team, is_accepted: true)}
    end

    it 'success' do
      @game.teams.should =~ @teams
    end
  end

  context 'teams_unaccepted' do
    before :each do
      @game = FactoryGirl.create(:game)
      @teams = 3.times.map { FactoryGirl.create(:team) }
      @accepted_teams = 3.times.map { FactoryGirl.create(:team) }
      @other_teams = 3.times.map { FactoryGirl.create(:team) }
      @teams.each { |team| FactoryGirl.create(:game_request, game: @game, team: team)}
      @accepted_teams.each { |team| FactoryGirl.create(:game_request, game: @game, team: team, is_accepted: true)}
    end

    it 'success' do
      @game.teams_unaccepted.should =~ @teams
    end
  end

end