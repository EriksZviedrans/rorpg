class ContentToolController < ApplicationController
	layout 'main'
      
        def index 
        session[:host] = params[:host]
	session[:name] = params[:name]
        session[:port] = params[:port]
        session[:username] = params[:username]
        session[:password] = params[:paswword]
        session[:database] = params[:database]
	begin
        $conn =  Content.dbconn(session[:host], session[:port], session[:username], session[:password], session[:database])
	$listdb = Content.dblist($conn)  
        redirect_to (  :action => 'db', :id => params[:database])
       	rescue PGError=>e
		redirect_to :back
		flash[:notice] = "#{e}"
	ensure
	 $conn.close if $conn.nil?
	end
        end

   
        def db
        $dbtype = params[:id]
        $conn = Content.dbconn(session[:host], session[:port], session[:username], session[:password],$dbtype)
        $versio = Content.version($conn).to_s
        $schemas =  Content.schema($conn)
  	$schematype =  params[:schema]
	$tables =  Content.tables($conn,$schematype)
        $views =  Content.views($conn,$schematype)
        $sequences =  Content.sequences($conn,$schematype)
        $functions =  Content.functions($conn,$schematype)
        end

	def dblist
	@dblist = Content.dblist($conn) 
	@encoding = Encoding.all
	end

	def table
	$table = params[:table]
        $info = Content.table_column_name($conn,$table)
	$info_struct = Content.table_columns($conn,$table,$schematype)
	$info.each do |row|
		if row['format_type'] == "bytea"
		@image_file = true
		else
		@image_file = false
		end
	end
	end
	
	def view
	@view = params[:view]
        $info = Content.table_column_name($conn,@view)
	$info_struct = Content.table_columns($conn,@view,$schematype)
	end  
	
	def sequence
	 @sequence = params[:sequence]
	 $info_struct = Content.sequence_columns($conn,@sequence,$schematype)
	end

	def function
	 @function = params[:function]
	 @types = Content.all
	 $info_struct = Content.function_columns($conn,@function,$schematype)
	end

        def closecon
                $conn.close if $conn.nil?
                redirect_to :controller => 'rorpg', :action => 'index'
        end
	
	def refresh
	begin
	$listdb.clear
	$conn.close
        $conn =  Content.dbconn(session[:host], session[:port], session[:username], session[:password], session[:database])
	$listdb = Content.dblist($conn)  
        redirect_to (  :action => 'db', :id => session[:database])
       	rescue PGError=>e
		redirect_to :back
		flash[:notice] = "#{e}"
	ensure
	 $conn.close if $conn.nil?
	end
	
	end
	
	def create_db
		begin
		Content.create_db($conn,params[:database_name],params[:encoding])
		redirect_to :back
	 	flash[:notice] = "Database has been created!"
		rescue PGError=>e
		redirect_to :back
		flash[:notice] = "#{e}"
	 	end	
	end

	def del_db
	@db_names = params[:db] || []
	begin 
		if @db_names.length > 0
	 	Content.drop_db($conn,@db_names.join(", "))
		redirect_to :back
	 	flash[:notice] = "Database/es has been removed!"
		else
	  	 redirect_to :back
	  	 flash[:notice] = "Select database!"
	 	end
	 	rescue PGError=>e
		 redirect_to :back
		 flash[:notice] = "#{e}"
	 end 
	end

	def create_schema
         @schema_name = params[:schema_name]
         @comments = params[:schema_comments]
	 begin
	 		if @schema_name.length > 0
         			Content.create_schema($conn,@schema_name,@comments)
         			redirect_to :action => "db",  :id => $dbtype
	 			flash[:notice] = "Scheme has been created!"
	 		else
         			redirect_to :back
			end
	rescue PGError=>e
		redirect_to :back
		flash[:notice] = "#{e}"
	 end
	end  	
        
        def del_schema
	 @schema_names = params[:schemas] || []
	 begin
		if @schema_names.length > 0
	  		if params[:cascade].to_s == "1"
	   		 Content.cascade_schema($conn,@schema_names.join(", "))
	   		 redirect_to :back
	   		 flash[:notice] = "Scheme/es has been removed(cascade)!"
 	  		else
	   	 	 Content.drop_schema($conn,@schema_names.join(", "))
	   	 	 redirect_to :back
	   	 	 flash[:notice] = "Scheme/es has been removed!"
			end
		else
	  	 redirect_to :back
	  	 flash[:notice] = "Select schema!"
	 	end
	 rescue PGError=>e
		 redirect_to :back
		 flash[:notice] = "#{e}"
	 end 
        end

	def tables
	@tables_list = Content.tables($conn,$schematype)
	end

        def del_tables
	 @tables_names = params[:tables] || []
	begin
	 	if @tables_names.length > 0
	  		if params[:cascade].to_s == "1"
	     		 Content.cascade_tables($conn,$schematype+"."+@tables_names.join(",#{$schematype}."))
	     		 redirect_to :back
	     		 flash[:notice] = "Table/es has been removed(cascade)!"
	  		else
	  		 Content.drop_tables($conn,$schematype+"."+@tables_names.join(",#{$schematype}."))
	  		 redirect_to :back
	  		 flash[:notice] = "Table/es has been removed!"
	 		end
	 	else
	  	 redirect_to :back
	   	 flash[:notice] = "Select table!"
	        end
	 rescue PGError=>e
		 redirect_to :back
		 flash[:notice] = "#{e}"
	 end
        end
        
        def nexts_step
          $table_name = params[:table_name] 
          $table_col_nu = params[:number_of_column]
          $oids = params[:oids]
          $table_comments = params[:table_comments]
          @types = Content.all
        end

        def create_table_final
	 @create_colums = ""
	 @colum_comments = ""
	 @primary_key = ""
	 i = 0 
	 $table_col_nu.to_i.times do
		if params[:column_name][i].to_s == ""
			break
		end
	
	 if params[:check_primary][i] == "True"
	 @primary_key += params[:column_name][i].to_s+", "
	 end
			if params[:column_length][i].empty?
			@create_colums += params[:column_name][i].to_s+" "+params[:colums_type][i].to_s+params[:type_of_type][i].to_s+" "+params[:check_null][i].to_s+" "+params[:check_uniyue][i].to_s+", "
			else 
			@create_colums += params[:column_name][i].to_s+" "+params[:colums_type][i].to_s+"("+params[:column_length][i]+")"+params[:type_of_type][i].to_s+" "+params[:check_null][i].to_s+" "+params[:check_uniyue][i].to_s+", "
			end
	 @colum_comments += "COMMENT ON COLUMN #{$schematype}.#{$table_name}.#{params[:column_name][i].to_s} IS '#{params[:column_comments][i].to_s}';"
		
		i += 1
	 end	
	 if @primary_key != ""
	 @create_colums += "PRIMARY KEY (#{@primary_key.chomp(", ")})"
	 end
	begin
	Content.create_table($conn,$schematype+"."+$table_name,@create_colums,$oids,$table_comments,@colum_comments)
	redirect_to :action =>"tables", :id => $dbtype+$schematype
	flash[:notice] = "Table has been created!"
	rescue PGError=>e
		redirect_to :action =>"tables", :id => $dbtype+$schematype
		flash[:notice] = "#{e}"
	end
        end
	
	def views
	@views_list = Content.views($conn,$schematype)
	end
	
	def del_views
	  @views_names = params[:views] || []
	 begin
	 if @views_names.length > 0
	  Content.drop_views($conn,$schematype+"."+@views_names.join(",#{$schematype}."))
	  redirect_to :back
	  flash[:notice] = "View/s has been removed!"
	 else
	  redirect_to :back
	  flash[:notice] = "Select view!"
	 end
	 rescue PGError=>e
		 redirect_to :back
		 flash[:notice] = "#{e}"
	 end
	end
	
	def create_view
	  @view_name = params[:view_name]
	  @view_definition = params[:view_definition]
	  @view_comments = params[:view_comments]
	begin
	Content.create_view($conn,@view_name,@view_definition,@view_comments)
	  redirect_to :action =>"views", :id => $dbtype+$schematype
	  flash[:notice] = "View has been created!"
	rescue PGError=>e
		redirect_to :back
		flash[:notice] = "#{e}"
	end
	end

	def sequences
	@sequences_list = Content.sequences($conn,$schematype)
	end
	
	def del_sequences
	  @sequences_names = params[:sequences] || []
	 begin
	 if @sequences_names.length > 0
	  Content.drop_sequences($conn,$schematype+"."+@sequences_names.join(",#{$schematype}."))
	  redirect_to :back
	  flash[:notice] = "Sequence/s has been removed!"
	 else
	  redirect_to :back
	  flash[:notice] = "Select sequence!"
	 end
	 rescue PGError=>e
		 redirect_to :back
		 flash[:notice] = "#{e}"
	 end
	end

	def create_sequence
	 begin
		if params[:cycled] == true
			@cycle = "CYCLE"
		else 
			@cycle = ""
		end
		Content.create_sequence($conn,params[:sequence_name],params[:increment_by],params[:min_value],params[:max_value],params[:start_value],params[:cache_value],@cycle,params[:sequence_comments])
		 redirect_to :action =>"sequences", :id => $dbtype+$schematype
	  	 flash[:notice] = "Sequence has been created!"
	 rescue PGError=>e
		redirect_to :back
		flash[:notice] = "#{e}"
	 end
	end
	
	def functions
	@functions_list = Content.functions($conn,$schematype)
	@types = Content.all
	end
	
	def create_function
	@argumentsq = ""
	@arguments = params[:arguments] || []
	i = 0
	@arguments.length.times do
		@argumentsq +=  params[:arguments][i].to_s+" "+params[:arguments_type][i].to_s+params[:arguments_type_of_type][i].to_s+", " 
	i += 1
	end
	 begin
	  Content.create_function($conn,params[:function_name],@argumentsq,params[:returns],params[:returns_type],params[:new_definition],params[:language],params[:properties],params[:execution_cost],params[:function_comments])
		redirect_to :action =>"functions", :id => $dbtype+$schematype
	  	flash[:notice] = "Function has been created!"
	  rescue PGError=>e
		redirect_to :back
		flash[:notice] = "#{e}"
	  end
	end
	
	def del_functions
	 @functions_names = params[:functions] || []
	 begin
	 if @functions_names.length > 0
	  Content.drop_functions($conn,$schematype+"."+@functions_names.join(",#{$schematype}."))
	  redirect_to :back
	  flash[:notice] = "Function/s has been removed!"
	 else
	  redirect_to :back
	  flash[:notice] = "Select function!"
	 end
	 rescue PGError=>e
		 redirect_to :back
		 flash[:notice] = "#{e}"
	 end
	end

	def add_row_table
	@collums = ""
	@min_query = ""
	@max_query =  params[:colums] || []
		@id  = $idr*$idc
		i = 0
	@id.times do
		@min_query += params[:colums][i]+" ', '"
	i += 1
	end
	@div_query = @max_query.join(" ', '")
	@div_query.slice!(0..@min_query.length-1)
		$info.each do |rows| 
			@collums += rows['name']+", "
		end
	 	begin
			Content.insert_value($conn,$schematype,$table,@collums,@div_query,@min_query)
			redirect_to :back
			flash[:notice] = "Table has been updated!"
	 	rescue PGError=>e
		 	redirect_to :back
		 	flash[:notice] = "#{e}"
		end
	end

	def export
	@db= ""
	@db_list= Content.dblist($conn) 
	@db_list.each do |row|
		@db += row['datname'] + " "
	end
	@arraydb = @db.split(' ')
	end
	
	def save_export
	system "pg_dump -U #{session[:username]} -cif #{params[:database_e]}.sql #{params[:database_e]}"
	 send_file "#{RAILS_ROOT}/#{params[:database_e]}.sql", :type=>"application/sql" 
	system "rm #{RAILS_ROOT}/#{params[:database_e]}.sql"
	end

	def code_image
	@aconn = Content.dbconn("localhost",5432,"blog","ruby","elibrary") 
          @image_datae = Content.image(@aconn)
		 @image_datae.each do |row|
			@image_data = row['img']
		end	
		
          @image = @image_data.binary_data 
         send_data (@image, :type => @image_data.content_type, :filename => @image_data.filename, :disposition => 'inline') 
end
end
