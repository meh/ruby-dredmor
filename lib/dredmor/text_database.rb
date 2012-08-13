#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/text_database/text'
require 'dredmor/text_database/tooltip'
require 'dredmor/text_database/quality'
require 'dredmor/text_database/material'
require 'dredmor/text_database/decoration'
require 'dredmor/text_database/phoneme'
require 'dredmor/text_database/noun'
require 'dredmor/text_database/adjective'
require 'dredmor/text_database/ichor'
require 'dredmor/text_database/random'
require 'dredmor/text_database/verb'
require 'dredmor/text_database/architecture'
require 'dredmor/text_database/insult'
require 'dredmor/text_database/first_name'
require 'dredmor/text_database/title'
require 'dredmor/text_database/wizard_name'

class Dredmor

class TextDatabase
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

Tooltip      = TextDatabase::Tooltip
Quality      = TextDatabase::Quality
Material     = TextDatabase::Material
Decoration   = TextDatabase::Decoration
Phoneme      = TextDatabase::Phoneme
Noun         = TextDatabase::Noun
Adjective    = TextDatabase::Adjective
Ichor        = TextDatabase::Ichor
Insult       = TextDatabase::Insult
Random       = TextDatabase::Random
Verb         = TextDatabase::Verb
Architecture = TextDatabase::Architecture
FirstName    = TextDatabase::FirstName
Title        = TextDatabase::Title
WizardName   = TextDatabase::WizardName

end
