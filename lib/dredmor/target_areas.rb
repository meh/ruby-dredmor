#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/target_areas/target_area'

class Dredmor

class TargetAreas
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game   = game
		@areas = []

		if xml = game.read_xml('manTemplateDB')
			xml.xpath('//template').each {|xml|
				@areas << TargetArea.new(game, xml)
			}
		end
	end

	def each (&block)
		@areas.each(&block)
	end

	def [] (id)
		find { |s| id === s.id }
	end
end

TargetArea = TargetAreas::TargetArea

end
