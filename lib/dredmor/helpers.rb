#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class String
	def to_class_name
		capitalize.gsub(/_(.)/) { |c| $1.upcase }
	end
end

class Symbol
	def to_class_name
		to_s.to_class_name.to_sym
	end
end
