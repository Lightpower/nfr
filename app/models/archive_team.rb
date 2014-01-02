class ArchiveTeam < ActiveRecord::Base

  has_many :archive_zones, through: :archive_team_zones, class_name: 'ArchiveZone', foreign_key: 'team_id'
  has_many :archive_team_codes,   class_name: 'ArchiveTeamCode',  foreign_key: 'team_id'
  has_many :archive_logs,         class_name: 'ArchiveLog',       foreign_key: 'team_id'
  has_many :archive_team_bonuses, class_name: 'ArchiveTeamBonus', foreign_key: 'team_id'
  has_many :archive_team_hints,   class_name: 'ArchiveTeamHint',  foreign_key: 'team_id'
  has_many :archive_team_zones,   class_name: 'ArchiveTeamZone',  foreign_key: 'team_id'

  belongs_to :game
  belongs_to :team

  attr_accessible :name, :alternative_name, :image_url, :team, :team_id, :game, :game_id

  ##
  # Try to apply all team bonuses to the code
  #
  def modify_bonus(code)
    bonus = code.bonus
    self.modifiable_bonuses.each { |team_bonus| bonus = team_bonus.modify_bonus(bonus, code.ko) }
    bonus || 0
  end

  ##
  # Modifiable bonuses (Multipliers)
  #
  def modifiable_bonuses
    archive_team_bonuses.where(bonus_type: TeamBonus::MODIFIABLE_TYPES)
  end

  ##
  # Action bonuses (Pirates)
  #
  def action_bonuses
    archive_team_bonuses.where(bonus_type: TeamBonus::ACTION_TYPES)
  end

  ##
  # Number of accepted codes in defined zone
  #
  def codes_number_in_zone(zone, time=Time.now)
    ArchiveTeamCode.codes_number_of_team(self.id, zone.try(:id), time)
  end

end
