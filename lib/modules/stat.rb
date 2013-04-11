# encoding: UTF-8
module Stat

  class << self

    ##
    # Show the statistics by each kingdoms.
    #
    # Params:
    # - asking_team {Team} - Team which is asking for statistics
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
    #
    #   {
    #     1 => {
    #       name: 'Winterfell',
    #       team_codes: 12,
    #       holder: {
    #         name: 'Starks',
    #         codes: 15,
    #         time: '01:23:45',
    #         image: '/images/starks.png',
    #       },
    #     2 => {
    #       name: 'Casterly Rocks',
    #       team_codes: 12,
    #       holder: {
    #         name: 'Lannisters',
    #         codes: 11,
    #         time: '03:03:17',
    #         image: '/images/starks.png'
    #       },
    #     }
    #   }
    #
    def total(asking_team)
      return [] unless asking_team.present? && asking_team.is_a?(Team)

      result = {}
      Zone.all.each do |zone|
        holder = zone.holder
        if holder
          team = holder.team
          result.merge!({
            zone.id =>{
              name: zone.name,
              class: zone.css_class,
              team_codes: asking_team.codes_number_in_zone(zone).round(3),
              holder: {
                name:  team.name,
                codes: team.codes_number_in_zone(zone).round(3),
                time:  holder.time.localtime.strftime('%H:%M:%S'),
                image: team.image_url
              }
            }
          })
        else
          result.merge!({
            zone.id =>{
              name: zone.name,
              class: zone.css_class,
              team_codes: 0,
              holder: {
                name:  'Free zone',
                codes: 0,
                time:  '22:00:00',
              }
            }
          })
        end
      end

      result
    end
  end
end