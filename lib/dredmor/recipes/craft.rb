#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Recipes

class Craft < Recipe
	def initialize (game, xml)
		super

		@name = xml.css('output').min_by { |o| o[:skill].to_i }[:name]

		@output = Output.new(self, xml)
		@input  = xml.css('input').map {|x| game.items!.grep(x[:name]) }
	end

	class Output
		attr_reader :game, :recipe, :required_level

		def initialize (recipe, xml)
			@game   = recipe.game
			@recipe = recipe

			@required_level = xml.css('output').min_by { |o| o[:skill].to_i }[:skill].to_i

			last    = nil
			@levels = xml.css('output').sort_by { |o| o[:skill].to_i }.reverse.map {|xml|
				Level.new(self, xml, xml[:skill].to_i, last)

				last = xml[:skill].to_i
			}.reverse
		end

		def for_level (n)
			@levels.find { |l| l === n }
		end

		class Level
			attr_reader :game, :recipe, :output, :item, :amount

			def initialize (output, xml, low, high = nil)
				@game   = output.game
				@recipe = output.recipe
				@output = output

				@low  = low
				@high = high

				@item   = game.items!.grep(xml[:name])
				@amount = (xml[:amount] || 1).to_i
			end

			def === (n)
				return true if @high.nil? && n >= @low

				return true if @high < n && n >= @low

				return false
			end

			alias <=> ===
		end
	end
end

end; end
