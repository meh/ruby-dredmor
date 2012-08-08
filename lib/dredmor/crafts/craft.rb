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

class Craft
	Required = Struct.new(:items, :level)

	attr_reader :game, :toolkit, :result, :required

	def initialize (game, xml)
		@game    = game
		@toolkit = game.items.toolkits.find { |t| t.type == xml.at('tool')[:tag].to_sym }
		@result  = game.items.find { |i| i.name == xml.at('output')[:name] }
		@secret  = xml[:hidden] == '1'

		@required = Required.new(
			xml.css('input').map { |x| game.items.find { |i| i.name == x[:name] } },
			xml.at('output')[:skill].to_i
		)
	end

	def secret?
		@secret
	end
end

end; end
