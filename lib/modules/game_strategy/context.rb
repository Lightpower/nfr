# encoding: UTF-8
require 'unicode'

##
# This module is used to perform Game standard operations:
# - send_code                 (pass the code/answer to the engine);
# - get_hint                  (get the hint);
# - get_code_by_action_bonus  (get code by action bonus, e.g. Robbing bonus).
# - attach_unzoned_code       (attach free code to some zone)
#
# Also, it prepare the data for rendering standard elements:
# - input block;
# - tasks block;
# - user information;
# - team information;
# - blitz information;
# - short log;
# - full log;
# - current statistics;
# - total results;
# - action block.
#
# All those element can be processed in full and mobile modes
#
# Also, it define the possible actions for Action block due to Game type and state (e.g. show action when it
# accessible only)
#
module GameStrategy
  class Context
    extend GameStrategy::Actions
    extend GameStrategy::Rendering
    extend GameStrategy::ActionPanel
  end
end