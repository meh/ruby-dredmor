#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Unified

class Texts < Unified
	include Enumerable

	def each (what = nil, &block)
		return enum_for :each, what unless block

		game.each {|part|
			part.texts.each(what, &block)
		}

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

end; end
