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

class Effect
	def self.new (spell, xml)
		return super unless self == Effect

		const_get(constants.find { |c| c.to_s.downcase == xml[:type] }).new(game, xml)
	end

	class Probability
		attr_reader :effect

		def initialize (effect, value)
			@effect = effect
			@value  = value.to_i
		end

		def to_i
			@value
		end

		def to_f
			to_i / 100.0
		end
	end

	class Scale
		attr_reader :effect, :primary, :secondary

		def initialize (effect, primary = nil, secondary = nil)
			@effect    = effect
			@primary   = primary
			@secondary = secondary
		end
	end

	attr_reader :game, :spell, :probability, :affects, :scales_on

	def initialize (spell, xml)
		@game  = spell.game
		@spell = spell

		@probability     = Probability.new(self, xml[:percent] ? xml[:percent].to_i : 100)
		@affects         = xml[:taxa] ? xml[:taxa].downcase.to_sym : :everyone
		@affects_corpses = xml[:affectsCorpses] == '1'
		@affects_self    = xml[:self] == '1'
		@bad             = xml[:bad] == '1'
		@bleed           = xml[:bleed] == '1'
		@burn            = xml[:burn] == '1'

		@scales_on = Scale.new(self, xml[:primaryScale], xml[:secondaryScale])
	end

	protected :initialize

	def affects_corpses?
		@affects_corpses
	end

	def affects_self?
		@affects_self
	end

	def bad?
		@bad
	end

	def bleed?
		@bleed
	end

	def burn?
		@burn
	end

	class AscendDungeonLevel < Effect
		public :initialize
	end

	class Bleed < Effect
		public :initialize
	end

	class Blind < Effect
		public :initialize
	end

	class Blink < Effect
		def initialize (spell, xml)
			super

			@skip_animation = xml[:skipanimation] == '1'
		end

		def skip_animation?
			@skip_animation
		end
	end

	class Charm < Effect
		attr_reader :turns

		def initialize (spell, xml)
			super

			@turns = xml[:turns].to_i
		end
	end

	class CleanseArtifact < Effect
		public :initialize
	end

	class Confuse < Effect
		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
		end

		def to_i
			@amount
		end
	end

	class ConsumeBooze < Effect
		public :initialize
	end

	class ConsumeFood < Effect
		public :initialize
	end

	class ConsumeAnything < Effect
		public :initialize
	end

	class Corrupt < Effect
		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
		end

		def to_i
			@amount
		end
	end

	class Create < Effect
		attr_reader :turns, :sprite

		def initialize (spell, xml)
			super

			@turns  = xml[:turns].to_i
			@sprite = game.read_icon xml[:objectSprite]
		end
	end

	class Damage < Effect
		def initialize (spell, xml)
			super

			@internal       = Dredmor::Damage.new(spell.game, xml)
			@affects_caster = xml[:affectsCaster] == '1'
			@midas          = xml[:midas] == '1'
		end

		def respond_to_missing? (*args)
			@internal.respond_to?(*args)
		end

		def method_missing (id, *args, &block)
			if @internal.respond_to? id
				return @internal.__send__ id, *args, &block
			end

			super
		end

		def affects_caster?
			@affects_caster
		end

		def midas?
			@midas
		end
	end

	class Dig < Effect
		def initialize (spell, xml)
			super

			@regenerate = xml[:regenGFX] == '1'
		end

		def regenerate?
			@regenerate
		end
	end

	class Displace < Effect
		public :initialize
	end

	class Drunkenness < Effect
		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
		end

		def to_i
			@amount
		end
	end

	class Dot < Effect
		attr_reader :turns

		def initialize (spell, xml)
			super

			@spell_name = xml[:spell]
			@turns      = xml[:amount].to_i
		end

		def spell
			@spell ||= game.spells![@spell_name]
		end
	end

	class Drain < Effect
		def initialize (spell, xml)
			super

			@internal       = Dredmor::Damage.new(spell.game, xml)
			@affects_caster = xml[:affectsCaster] == '1'
			@midas          = xml[:midas] == '1'
		end

		def respond_to_missing? (*args)
			@internal.respond_to?(*args)
		end

		def method_missing (id, *args, &block)
			if @internal.respond_to? id
				return @internal.__send__ id, *args, &block
			end

			super
		end

		def affects_caster?
			@affects_caster
		end

		def midas?
			@midas
		end
	end

	class DrainMana < Effect
		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
		end

		def to_i
			@amount
		end

		def to_f
			to_i / 100.0
		end
	end

	class DrainCasterMana < Effect
		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
		end

		def to_i
			@amount
		end

		def to_f
			to_i / 100.0
		end
	end

	class DropItem < Effect
		public :initialize
	end

	class Fear < Effect
		attr_reader :turns

		def initialize (spell, xml)
			super

			@turns = xml[:amount].to_i
		end
	end

	class FindRecipe < Effect
		public :initialize
	end

	class GrabItem < Effect
		public :initialize
	end

	class GrantXP < Effect
		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
		end

		def to_i
			@amount
		end
	end

	class Heal < Effect
		attr_reader :scale

		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
			@scale  = xml[:amountF].to_f
		end

		def to_f (power = 0)
			@amount + (@scale * power)
		end

		def to_i (*args)
			to_f(*args).to_i
		end
	end

	class Knock < Effect
		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
		end

		def to_i
			@amount
		end
	end

	class Lockdown < Effect
		attr_reader :turns

		def initialize (spell, xml)
			super

			@turns = xml[:amount].to_i
		end
	end

	class MagicMapping < Effect
		public :initialize
	end

	class ManipulateObject < Effect
		public :initialize
	end

	class MoveRandomCurse < Effect
		attr_reader :type

		def initialize (spell, xml)
			super

			if type = xml[:buffTag]
				@type = type.to_sym
			end
		end
	end

	class MoveCurses < Effect
		attr_reader :type

		def initialize (spell, xml)
			super

			if type = xml[:buffTag]
				@type = type.to_sym
			end
		end
	end

	class Oil < Effect
		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
		end

		def to_i
			@amount
		end
	end

	class Pacify < Effect
		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
		end

		def to_i
			@amount
		end
	end

	class RandomizeArtifact < Effect
		public :initialize
	end

	class RandomizeWand < Effect
		public :initialize
	end

	class RandomUncurse < Effect
		attr_reader :type

		def initialize (spell, xml)
			super

			if type = xml[:buffTag]
				@type = type.to_sym
			end
		end
	end

	class RechargeAnvil < Effect
		public :initialize
	end

	class RemoveMonster < Effect
		public :initialize
	end

	class ResetRandomCooldown < Effect
		public :initialize
	end

	class ResetCooldowns < Effect
		public :initialize
	end

	class RechargeWand < Effect
		public :initialize
	end

	class RemoveBuffByName < Effect
		def initialize (spell, xml)
			super

			@name   = xml[:name]
			@amount = xml[:amount].to_i
		end

		def all?
			to_i.zero?
		end

		def to_i
			@amount
		end
	end

	class RemoveInvisibility < Effect
		public :initialize
	end

	class Rift < Effect
		public :initialize
	end

	class Root < Effect
		public :initialize
	end

	class SacrificeArtifact < Effect
		public :initialize
	end

	class Shout < Effect
		public :initialize
	end

	class Sleep < Effect
		attr_reader :probability, :turns

		def initialize (spell, xml)
			super

			@probability = Probability.new(self, ((1 / xml[:amount].to_f) * 100).to_i)
			@turns       = xml[:turns].to_i
		end
	end

	class Spawn < Effect
		attr_reader :amount

		def initialize (spell, xml)
			super

			@item_name = xml[:itemName]
			@amount    = (xml[:amount] || 1).to_i
		end

		def item
			@item ||= if %w[randomgem randommushroom randomring].include?(@item_name)
				 @item_name[6 .. -1].to_sym
			else
				game.items![@item_name]
			end
		end
	end

	class SpawnItemAtLocation < Effect
		attr_reader :amount

		def initialize (spell, xml)
			super

			@item_name = xml[:itemName]
			@amount    = (xml[:amount] || 1).to_i
		end

		def item
			@item ||= if %w[randomgem randommushroom randomring].include?(@item_name)
				 @item_name[6 .. -1].to_sym
			else
				game.items![@item_name]
			end
		end
	end

	class SpawnItemFromList < Effect
		class Item
			attr_reader :effect, :amount

			def initialize (effect, xml)
				@effect = effect

				@amount = (xml[:amount] || 1).to_i
				@name   = xml[:name]
			end

			def item
				@item ||= effect.game.items![@name]
			end
		end

		attr_reader :items

		def initialize (spell, xml)
			super

			@items = xml.css('option').map {|xml|
				Item.new(self, xml)
			}.freeze
		end
	end

	class SpellPoints < Effect
		attr_reader :scale

		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i
			@scale  = xml[:amountF].to_f
		end

		def to_f (power = 0)
			@amount + (@scale * power)
		end

		def to_i (*args)
			to_f(*args).to_i
		end
	end

	class Suction < Effect
		public :initialize
	end

	class Summon < Effect
		attr_reader :limit

		def initialize (spell, xml)
			super

			@monster_name = xml[:monsterType]
			@limit        = xml[:amount].to_i
		end

		def monster
			game.monsters![@monster_name]
		end
	end

	class SummonHostile < Effect
		def initialize (spell, xml)
			super

			@monster_name = xml[:monsterType]
		end

		def monster
			game.monsters![@monster_name]
		end
	end

	class SwapWithMonster < Effect
		def initialize (spell, xml)
			super

			@skip_animation = xml[:skipanimation] == '1'
		end

		def skip_animation?
			@skip_animation
		end
	end

	class TargetBlink
		public :initialize
	end

	class Teleport < Effect
		def initialize (spell, xml)
			super

			@skip_animation = xml[:skipanimation] == '1'
		end

		def skip_animation?
			@skip_animation
		end
	end

	class TransformMonster < Effect
		public :initialize
	end

	class Trigger < Effect
		attr_reader :delay

		def initialize (spell, xml)
			super

			@spell_name = xml[:spell]
			@delay      = xml[:amount].to_i

			@required_buff        = xml[:requirebuffontriggername]
			@required_absent_buff = xml[:requirebuffonnotriggername]
		end

		def requires_buff?
			!!@required_buff
		end

		def required_buff
			@required_buff
		end

		def requires_absent_buff?
			!!@required_absent_buff
		end

		def required_absent_buff
			@required_absent_buff
		end

		def spell
			@spell ||= game.spells![@spell_name]
		end
	end

	class Uncurse < Effect
		attr_reader :type

		def initialize (spell, xml)
			super

			@amount = xml[:amount].to_i

			if type = xml[:buffTag]
				@type = type.to_sym
			end
		end

		def to_i
			@amount
		end
	end
end

end; end
