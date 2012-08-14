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
	def self.new (game, xml)
		return super unless self == Spell

		const_get(constants.find { |c| c.to_s.downcase == xml[:type] }).new(game, xml)
	end

	attr_reader :game, :name, :description, :text, :icon, :requirements, :buff, :effects

	def initialize (game, xml)
		@game = game

		@type = xml[:type].to_sym
		@name = xml[:name]

		if description = xml.at('description')
			@description = description[:text]
			@text        = description[:monsterText]
		end

		if xml[:icon]
			@icon = game.read_icon(xml[:icon])
		end

		if requirements = xml.at('requirements')
			@requirements = Requirements.new(requirements[:mp].to_i, requirements[:mincost].to_f, requirements[:savvyBonus].to_f)
		end

		if buff = xml.at('buff')
			@buff = Buff.new(self, buff)
		end

		@effects = xml.css('effect').map {|xml|
			Effect.new(self, xml)
		}
	end

	protected :initialize

	def buff?
		!!@buff
	end

	def type
		self.class.name.downcase[/(?:::)?([^:]+)$/, 1].to_sym
	end

	def inspect
		"#<Dredmor::Spell(#{name})>"
	end

	class Requirements
		attr_reader :minimum, :bonus

		def initialize (amount, minimum = 0.0, bonus = 0.0)
			@amount  = amount
			@minimum = minimum
			@bonus   = bonus
		end

		def cost (savvy = 0.0)
			if (result = to_f - (savvy * bonus)) > minimum
				return result
			end

			minimum
		end

		def to_f
			@amount
		end

		def to_i
			to_f.to_i
		end
	end

	class Adjacent < Spell
		public :initialize
	end

	class AdjacentWall < Spell
		public :initialize
	end

	class Area < Spell
		public :initialize
	end

	class Beam < Spell
		public :initialize
	end

	class BeamMissile < Spell
		public :initialize
	end

	class Cone < Spell
		public :initialize
	end

	class DiggingBeam < Spell
		public :initialize
	end

	class Fireball < Spell
		public :initialize
	end

	class Item < Spell
		public :initialize
	end

	class KnightlyLeap < Spell
		public :initialize
	end

	class Missile < Spell
		public :initialize
	end

	class Rook < Spell
		public :initialize
	end

	class Self < Spell
		public :initialize
	end

	class Target < Spell
		public :initialize
	end

	class TargetAdjacentCorpse < Spell
		public :initialize
	end

	class TargetCorpse < Spell
		public :initialize
	end

	class TargetEmptyFloor < Spell
		public :initialize
	end

	class TargetFloor < Spell
		public :initialize
	end

	class TargetFloorItem < Spell
		public :initialize
	end

	class TargetMonster < Spell
		public :initialize
	end

	class TargetArea < Spell
		public :initialize
	end

	Template = TargetArea
end

end; end
