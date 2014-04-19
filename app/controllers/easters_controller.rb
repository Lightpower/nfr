# encoding: UTF-8
class EastersController < ApplicationController

  def filler ; end

  # Miner mini-game
  def miner
    if params[:l]
      field_array = [
        [73, [4, 131072, 135176, 4194464, 532992, 12, 18, 9335170, 21238402, 21262722, 29627026, 21262732, 0, 0, 8650784, 17408, 786436, 4194337, 4194304]],
      ]
      i = (Time.now.strftime('%S').to_i / 60)
      @miner_field_data = [25, 20, field_array[i][0], field_array[i][1].join(',') ].join(';')
    end
  end
end