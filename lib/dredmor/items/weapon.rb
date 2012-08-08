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

class Weapon < Item
	def self.to_a
		@array ||= [Sword, Axe, Mace, Staff, Crossbow, Thrown, Bolt, Dagger, Polearm]
	end

	def self.new (game, xml)
		return super unless self == Weapon

		to_a[xml[:type].to_i].new(game, xml)
	end

	include WithBuffs

	attr_reader :level, :quality, :damage

	def initialize (game, xml)
		super

		@level  = xml[:level].to_i
		@damage = Damage.new(game, xml.at('weapon'))

		if artifact = xml.at('artifact')
			@quality = artifact[:quality].to_i
		end

		from_xml(xml)

		@buffs.reject! { |b| b.is_a? Damage }
	end

	protected :initialize

	def type
		self.class.name.downcase[/(?:::)?([^:]+)$/, 1].to_sym
	end

	def artifact?
		!!@quality
	end

	class Melee < Weapon
		public :initialize

		class Sword < Melee
		end

		class Axe < Melee
		end

		class Mace < Melee
		end

		class Staff < Melee
		end

		class Dagger < Melee
		end

		class Polearm < Melee
		end
	end

	class Ranged < Weapon
		attr_reader :sprite, :limit

		def initialize (game, xml)
			super

			if hit = xml.at('weapon')[:hit]
				on(:hit) << Spells::Probability.new(game.spells[hit], 100)
			end

			if thrown = xml.at('weapon')[:thrown]
				@sprite = game.read_icon(thrown)
			end

			@can_target_floor = xml.at('weapon')[:canTargetFloor] == '1'
			@limit            = xml.at('weapon')[:maxstack].to_i
		end

		def can_target_floor?
			@can_target_floor
		end

		class Thrown < Ranged
		end

		class Bolt < Ranged
		end
	end

	class Crossbow < Weapon
		public :initialize
	end

	Sword   = Melee::Sword
	Axe     = Melee::Axe
	Mace    = Melee::Mace
	Staff   = Melee::Staff
	Dagger  = Melee::Dagger
	Polearm = Melee::Polearm

	Thrown   = Ranged::Thrown
	Bolt     = Ranged::Bolt
end

end; end
