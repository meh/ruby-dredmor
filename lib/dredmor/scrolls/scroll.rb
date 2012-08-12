#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Scrolls

class Scroll
	attr_reader :game, :name, :description, :level, :effect, :icon

	def initialize (game, xml)
		@game = game

		@name        = xml[:name]
		@description = xml.at('description')[:text].freeze
		@level       = xml[:level].to_i
		@effect      = game.spells![xml.at('casts')[:spell]]

		@icon = game.read_sprite xml[:iconFile]
	end

	def inspect
		"#<Dredmor::Scroll(#{name}): #{description.inspect}>"
	end
end

end; end
