# encoding: UTF-8
class EastersController < ApplicationController

  def filler ; end

  # Miner mini-game
  def miner
    if params[:l]
      field_array = [
        [73, [4, 131072, 135176, 160, 532992, 12, 18, 946562, 266882, 291202, 266898, 291212, 0, 0, 262176, 17408, 786436, 33, 0]],
      ]
      i = (Time.now.strftime('%S').to_i / 60)
      @miner_field_data = [25, 20, field_array[i][0], field_array[i][1].join(',') ].join(';')
    end
  end
end