module ContentToolHelper
	def objectsfounds?
                return false if $info_struct.count == 0 
                return true
        end

        def objectsfounds_table?
                return false if @tables_list.count == 0 
                return true
        end
	
	def objectsfounds_views?
                return false if @views_list.count == 0 
                return true
        end
	
	def objectsfounds_sequences?
                return false if @sequences_list.count == 0 
                return true
        end

	def objectsfounds_functions?
                return false if @functions_list.count == 0 
                return true
        end
end
