# encoding: UTF-8
require 'spec_helper'

describe 'ArchiveFacade' do

  context 'archive' do
    before :each do
      @game = create_simple_game
      emulate_game_activity(@game)
      @table_names = %w(Zone Task Code CodeString Hint TeamBonus TeamCode TeamHint TeamZone Log)
    end

    it "success" do
      tables_size = {}
      # Remember the number of records in each table
      @table_names.each do |table|
        tables_size.merge!(table => table.constantize.where(game_id: @game.id).size)
      end
      tables_size.merge!("Team" => GameRequest.where(game_id: @game.id).size)

      ArchiveFacade.archive(@game)
      @game.reload

      # Check each table
      @table_names.each do |table|
        tables_size[table].should == "Archive#{table}".constantize.where(game_id: @game.id).size
        table.constantize.where(game_id: @game.id).size.should == 0
      end

      # Check teams
      tables_size["Team"].should == ArchiveTeam.where(game_id: @game.id).size

      # Check the game
      @game.is_archived.should be_true
      @game.is_active.should be_false
    end
  end

  context 'copy_from_archive' do
    before :each do
      @game = create_simple_game
      ArchiveFacade.archive(@game)
      @table_names = %w(Zone Task Code CodeString Hint)
    end

    it "success" do

      new_game = ArchiveFacade.copy_from_archive(@game)

      # Check each table
      @table_names.each do |table|
        table.constantize.where(game_id: new_game.id).size.should == "Archive#{table}".constantize.where(game_id: @game.id).size
      end

      # Check the game
      Game.column_names.each do |name|
        next if %w(id number name is_active is_archived).include?(name)
        new_game.send(name).should == @game.send(name)
      end
      new_game.number.should == @game.number * 1000
      new_game.name.should == "#{@game.name} (копия)"
    end
  end
end