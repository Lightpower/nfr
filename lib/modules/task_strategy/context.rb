# encoding: UTF-8
require 'unicode'

##
# This module is used to perform Task common rendering:
# - codes_block   (make HTML-string to present codes information);
#
# All those elements can be processed in full and mobile modes
#
module TaskStrategy
  class Context
    extend TaskStrategy::Rendering
  end
end