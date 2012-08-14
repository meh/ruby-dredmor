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

class Armour < Item
	def self.new (game, xml)
		return super unless self == Armour

		const_get(xml[:type].to_class_name).new(game, xml)
	end

	include WithBuffs

	attr_reader :level, :quality, :resistance

	def initialize (game, xml)
		super

		@level      = xml.at('armour')[:level].to_i
		@resistance = Resistance.new(game, xml.at('resistbuff'))

		if artifact = xml.at('artifact')
			@quality = artifact[:quality].to_i
		end

		from_xml(xml)

		@buffs.reject! { |b| b.is_a? Resistance }
	end

	protected :initialize

	def type
		self.class.name.downcase[/(?:::)?([^:]+)$/, 1].to_sym
	end

	def artifact?
		!!@quality
	end

	class Head < Armour
		public :initialize
	end

	class Chest < Armour
		public :initialize
	end

	class Legs < Armour
		public :initialize
	end

	class Hands < Armour
		public :initialize
	end

	class Feet < Armour
		public :initialize
	end

	class Neck < Armour
		public :initialize
	end

	class Ring < Armour
		public :initialize
	end

	class Shield < Armour
		public :initialize
	end

	class Sleeve < Armour
		public :initialize
	end
end

end; end
