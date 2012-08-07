#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/skills/skill'
require 'dredmor/skills/ability'
require 'dredmor/skills/inventory'

class Dredmor

class Skills
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game   = game
		@skills = []

		game.read_xml('skillDB').xpath('//skill').each {|xml|
			@skills << Skill.new(game, xml)
		}
	end

	def each (&block)
		@skills.each(&block)
	end

	def [] (name_or_id)
		find { |s| name_or_id === s.id || name_or_id === s.name }
	end
end

Skill   = Skills::Skill
Ability = Skills::Ability

end
