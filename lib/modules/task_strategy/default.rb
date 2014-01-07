module TaskStrategy

  ##
  # Strategy for Task with task_type = "" (defult)
  #
  module Default
    extend TaskStrategy::Default::Rendering
  end
end