#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Crafts

class Craft < Recipe
	attr_reader :result

	def initialize (game, xml)
		super

		@name     = xml.at('output')[:name]
		@required = Required.new(
			xml.css('input').map { |x| game.items.find { |i| i.name == x[:name] } },
			xml.at('output')[:skill].to_i
		)

		@result = game.items.find { |i| i.name == xml.at('output')[:name] }
	end
end

end; end
