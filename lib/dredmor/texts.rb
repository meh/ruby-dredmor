#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/texts/text'
require 'dredmor/texts/tooltip'
require 'dredmor/texts/quality'
require 'dredmor/texts/material'
require 'dredmor/texts/decoration'
require 'dredmor/texts/phoneme'
require 'dredmor/texts/noun'
require 'dredmor/texts/adjective'
require 'dredmor/texts/ichor'
require 'dredmor/texts/random'
require 'dredmor/texts/verb'
require 'dredmor/texts/architecture'
require 'dredmor/texts/insult'
require 'dredmor/texts/first_name'
require 'dredmor/texts/title'
require 'dredmor/texts/wizard_name'

class Dredmor

class Texts
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game = game

		@tooltips      = []
		@quality       = []
		@materials     = []
		@decorations   = []
		@phonemes      = []
		@nouns         = []
		@adjectives    = []
		@ichors        = []
		@insults       = []
		@random        = []
		@verbs         = []
		@architectures = []
		@first_names   = []
		@titles        = []
		@wizard_names  = []

		if xml = game.read_xml('text')
			xml.xpath('//tooltip').each {|xml|
				@tooltips << Tooltip.new(game, xml)
			}

			xml.xpath('//quality').each {|xml|
				@quality << Quality.new(game, xml)
			}

			xml.xpath('//material').each {|xml|
				@materials << Material.new(game, xml)
			}

			xml.xpath('//decoration').each {|xml|
				@decorations << Decoration.new(game, xml)
			}

			xml.xpath('//startPhoneme').each {|xml|
				@phonemes << Phoneme.new(game, xml, true)
			}

			xml.xpath('//phoneme').each {|xml|
				@phonemes << Phoneme.new(game, xml, false)
			}

			xml.xpath('//noun').each {|xml|
				@nouns << Noun.new(game, xml)
			}

			xml.xpath('//adjective').each {|xml|
				@adjectives << Adjective.new(game, xml)
			}

			xml.xpath('//ichor').each {|xml|
				@ichors << Ichor.new(game, xml)
			}

			xml.xpath('//insult').each {|xml|
				@insults << Insult.new(game, xml)
			}

			xml.xpath('//random').each {|xml|
				@random << Random.new(game, xml)
			}

			xml.xpath('//verb').each {|xml|
				@verbs << Verb.new(game, xml)
			}

			xml.xpath('//architecture').each {|xml|
				@architectures << Architecture.new(game, xml)
			}

			xml.xpath('//firstname').each {|xml|
				@first_names << FirstName.new(game, xml)
			}

			xml.xpath('//title').each {|xml|
				@titles << Title.new(game, xml)
			}

			xml.xpath('//wizardname').each {|xml|
				@wizard_names << WizardName.new(game, xml)
			}
		end
	end

	def each (what = nil, &block)
		return enum_for :each, what unless block

		if what
			(instance_variable_get("@#{what}s") || instance_variable_get("@#{what}")).each(&block)
		else
			each(:tooltip, &block)
			each(:quality, &block)
			each(:material, &block)
			each(:decoration, &block)
			each(:phoneme, &block)
			each(:noun, &block)
			each(:adjective, &block)
			each(:ichor, &block)
			each(:random, &block)
			each(:verb, &block)
			each(:insult, &block)
			each(:first_name, &block)
			each(:title, &block)
			each(:wizard_name, &block)
		end

		self
	end

	%w[tooltip material decoration phoneme noun adjective ichor random verb insult first_name title wizard_name].each {|name|
		define_method "#{name}s" do |&block|
			each(name, &block)
		end
	}

	def qualities (&block)
		each(:quality, &block)
	end
end

Tooltip      = Texts::Tooltip
Quality      = Texts::Quality
Material     = Texts::Material
Decoration   = Texts::Decoration
Phoneme      = Texts::Phoneme
Noun         = Texts::Noun
Adjective    = Texts::Adjective
Ichor        = Texts::Ichor
Insult       = Texts::Insult
Random       = Texts::Random
Verb         = Texts::Verb
Architecture = Texts::Architecture
FirstName    = Texts::FirstName
Title        = Texts::Title
WizardName   = Texts::WizardName

end
