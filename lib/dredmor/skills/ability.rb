#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Skills

class Ability
	include WithBuffs

	attr_reader :game, :skill, :level, :name, :description, :icon, :spells, :learn

	def initialize (skill, xml)
		@game  = skill.game
		@skill = skill

		@level       = xml[:level].to_i
		@name        = xml[:name]
		@description = xml.at('description')[:text]

		@icon   = game.read_icon xml[:icon]
		@spells = xml.css('spell').map { |x| game.spells[x[:name]] }

		if recipe = xml[:learnrecipe]
			@learn = game.recipes[recipe]
		end

		from_xml(xml)
	end

	def to_str
		@name
	end

	def inspect
		"#<Dredmor::Ability(#{name}): #{description.inspect}>"
	end
end

end; end
