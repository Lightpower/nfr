# encoding: UTF-8
module TaskStrategy

  ##
  # Strategy for Task with task_type = "" (default)
  #
  module Default
    extend TaskStrategy::Default::Rendering
  end
end