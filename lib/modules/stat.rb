# encoding: UTF-8
module Stat

  class << self

    ##
    # Show the statistics by each kingdoms.
    #
    # Params:
    # - team {Team} - Team which is asking for statistics
    #
    #
    # Returns:
    # - {Array of Hash} - List of data by each kingdoms:
    #   - Name
    #   - Master
    #   - Code number of Master
    #   - How long is captured (in minutes)
    #   - Color of Master
    #   - Link to image of Master
    #   - Code number of asking team
    #
    # Example:
    #
    # [
    #   {
    #     'Winterfell' => {
    #       master: {
    #         name: 'Starks',
    #         codes: 15,
    #         time: '01:23:45',
    #         color: 15,
    #         image: '/images/starks.png',
    #         team_codes: 12,
    #       },
    #     'Casterly Rocks' => {
    #       master: {
    #         name: 'Lannisters',
    #         codes: 11,
    #         time: '03:03:17',
    #         color: 15,
    #         image: '/images/starks.png',
    #         team_codes: 12,
    #       },
    #     }
    #   }
    #
    #
    #
    #
    # ]
    #
    def total(team)
      return [] unless team.present? && team.is_a?(Team)

      Zone.all.each do |zone|


      end
    end

  end
end