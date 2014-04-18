# encoding: UTF-8
class EastersController < ApplicationController

  def filler ; end

  # Miner mini-game
  def miner
    if params[:l]
      field_array = [
        [73, [4, 16384, 17416, 262240, 67840, 12, 18, 646338, 1344834, 1350850, 1869138, 1350860, 0, 0, 557088, 4608, 98308, 262177, 262144]],
      ]
      i = (Time.now.strftime('%S').to_i / 60)
      @miner_field_data = [22, 20, field_array[i][0], field_array[i][1].join(',') ].join(';')
    end
  end
end