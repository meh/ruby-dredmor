#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Spells

class Spell
	attr_reader :game, :type, :name, :description, :says, :icon

	def initialize (game, xml)
		@game = spells.game

		@type        = xml[:type].to_sym
		@name        = xml[:name]
		@description = xml.xpath('.//description[1]/@text').first.value
		@says        = xml.xpath('.//description[1]/@monsterText').first.value rescue nil

		if xml[:icon]
			@icon = Icon.load(game, xml[:icon])
		end
	end

	def inspect
		"#<Dredmor::Spell(#{name}, #{type}): #{description.inspect}>"
	end
end

end; end
