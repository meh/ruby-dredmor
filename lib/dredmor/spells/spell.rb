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
		@game = game

		@type = xml[:type].to_sym
		@name = xml[:name]

		if description = xml.at('description')
			@description = description[:text]
			@says        = description[:monsterText]
		end

		if xml[:icon]
			@icon = game.read_icon(xml[:icon])
		end
	end

	def inspect
		"#<Dredmor::Spell(#{name})[#{type}]: #{description.inspect}>"
	end
end

end; end
