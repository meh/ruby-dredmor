#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Items

class Item
	attr_reader :game, :name, :description, :price, :icon

	def initialize (game, xml)
		@game = game

		@name        = xml[:name]
		@description = xml.at('description')[:text]
		@price       = xml.at('price')[:amount].to_i rescue 0
		@special     = xml[:special] == '1'

		if xml[:iconFile]
			@icon = game.read_icon xml[:iconFile]
		end
	end

	protected :initialize

	def special?
		@special
	end

	def to_str
		@name
	end

	def inspect
		"#<Dredmor::Item(#{name}, #{price} zorkimnds)#{": #{description.inspect}" if description}>"
	end
end

end; end
