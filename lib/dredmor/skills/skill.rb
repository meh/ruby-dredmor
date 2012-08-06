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

class Skill
	include Enumerable

	attr_reader :game, :id, :type, :name, :description, :ability, :icon

	def initialize (game, xml)
		@game = game

		@id          = xml[:id].to_i
		@type        = xml[:type].to_sym
		@name        = xml[:name]
		@description = xml[:description]

		@ability   = Ability.new(self, xml.xpath("//ability[@skill='#@id' and (@startSkill or @startskill)]").first)
		@abilities = xml.xpath("//ability[@skill='#@id' and not(@startSkill or @startskill)]").map {|xml|
			Ability.new(self, xml)
		}.sort_by(&:level)

		@icon = Icon.load(game, xml.xpath('.//art/@icon').first.value)
	end

	def each (&block)
		@abilities.each(&block)
	end

	def [] (name_or_level)
		find { |s| s.level == name_or_level || s.name == name_or_level }
	end

	def inspect
		"#<Dredmor::Skill(#{name}): #{description.inspect}>"
	end
end

end; end
