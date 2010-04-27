class Content < ActiveRecord::Base    
private
        def self.dbconn(host, port, username, password, database)
                   return PGconn.new(host, port, '', '', database, username, password)
        end
        
        def self.version(conn)
                 res  = conn.exec('SELECT version()')
                 res.each do |row|
	                row.each do | version|
                                     return  version[1]
	                end
	        end
        end

        def self.dblist(conn)
                return conn.exec("SELECT datname FROM pg_database WHERE datname != 'template0' AND datname != 'template1'")
        end
       	
        def self.schema(conns)
		return conns.exec("SELECT schema_name, 
	                                  schema_owner, 
	                                  catalog_name, 
	                                  pg_catalog.obj_description(pg_namespace.oid) AS __Comments
                                FROM information_schema.schemata
                                        LEFT JOIN pg_namespace  ON  nspname = schema_name
	                                WHERE schema_name != 'pg_toast' 
		                        AND schema_name != 'pg_catalog'
		                        AND schema_name != 'pg_temp_1'
		                        AND schema_name != 'pg_toast_temp_1'
		                        AND schema_name != 'information_schema'")
        end
	
	def self.tables(conntable,schematype)
		return conntable.exec("SELECT table_name, tableowner AS Owner, obj_description(pg_class.oid) AS __Comments FROM information_schema.tables
					LEFT JOIN pg_class ON relname = table_name   
					LEFT JOIN pg_tables ON table_name = tablename  
					WHERE table_schema='#{schematype}' AND table_type = 'BASE TABLE'")
	end
	def self.views(connview,schematype)
		return connview.exec("SELECT table_name AS view_name,obj_description(pg_class.oid) AS __Comments, viewowner AS Owner FROM information_schema.views 
					LEFT JOIN pg_class ON relname = table_name   
					LEFT JOIN pg_views ON table_name = viewname
					WHERE table_schema='#{schematype}'")
	end
        def self.sequences(connsequences,schematype)
		return connsequences.exec("SELECT sequence_name,obj_description(pg_class.oid) AS __Comments, usename AS Owner FROM information_schema.sequences 
					LEFT JOIN pg_class ON relname = sequence_name
					LEFT JOIN pg_shadow ON usesysid = relowner
					WHERE sequence_schema='#{schematype}'")
	end
	def self.functions(connfunctions,schematype)
		return connfunctions.exec("SELECT p.proname AS _function_name, pg_catalog.oidvectortypes(p.proargtypes) as argument, ds.description AS _comments, u.usename AS Owner FROM pg_proc p
					LEFT OUTER JOIN pg_description ds ON ds.objoid = p.oid
					INNER JOIN pg_namespace n ON p.pronamespace = n.oid
					LEFT OUTER JOIN pg_user u ON u.usesysid = p.proowner
					WHERE n.nspname = '#{schematype}'")
	end
	def self.table_column_name(conninfo,table)
		return conninfo.exec("SELECT a.attname AS name, format_type(a.atttypid, a.atttypmod) AS format_type FROM pg_class c, pg_attribute a
					WHERE c.relname = '#{table}'
  					AND a.attnum > 0 AND a.attrelid = c.oid
					ORDER BY a.attnum")
	end
	def self.table_columns(conninfo,table,schematype)
		@name= ""

		columns  = conninfo.exec("SELECT a.attname AS name, format_type(a.atttypid, a.atttypmod) AS format_type FROM pg_class c, pg_attribute a
					WHERE c.relname = '#{table}'
  					AND a.attnum > 0 AND a.attrelid = c.oid
					ORDER BY a.attnum")
		@nr = 'a'
		columns.each do |row|
		@name += row['name']+" AS #{@nr}, "
		@nr = @nr.succ
		end

		return conninfo.exec("SELECT #{@name.chomp(", ")} FROM #{schematype}.#{table}" )
	end
	def self.sequence_columns(conninfo,sequence,schematype)
		return conninfo.exec("SELECT sequence_name, last_value, start_value AS _start_value, increment_by AS _increment_by, max_value, cache_value AS _cache_value, log_cnt AS Log_Count, is_cycled AS Is_cycled, is_called AS is_called FROM #{schematype}.#{sequence}")
	end
	def self.function_columns(conninfo,function,schematype)
		return conninfo.exec("SELECT p.proname AS name,pg_catalog.oidvectortypes(p.proargtypes) as argument, pg_catalog.format_type(p.prorettype, NULL) as returns, p.prosrc AS definition, l.lanname AS language, u.usename AS owner FROM pg_proc p
				LEFT JOIN pg_catalog.pg_namespace x ON x.oid = p.pronamespace
				INNER JOIN pg_namespace n ON p.pronamespace = n.oid
				INNER JOIN pg_language l ON l.oid = p.prolang
				LEFT OUTER JOIN pg_user u ON u.usesysid = p.proowner
				WHERE n.nspname = '#{schematype}' AND p.proname = '#{function}'")
	end
	def self.create_db(conninfo,db_name,encoding)
		return conninfo.exec("CREATE DATABASE #{db_name} WITH ENCODING '#{encoding}';")
	end
	def self.drop_db(conninfo,db_name)
		return conninfo.exec("DROP DATABASE #{db_name}")
	end	
	def self.create_schema(conninfo,schema,comments)
                return conninfo.exec("CREATE SCHEMA #{schema};
                COMMENT ON SCHEMA #{schema} IS '#{comments}';")
	end
        def self.drop_schema(conninfo,schemas)
                return conninfo.exec("DROP SCHEMA #{schemas}")
        end
	def self.cascade_schema(conninfo,schemas)
                return conninfo.exec("DROP SCHEMA #{schemas} CASCADE")
        end
        def self.drop_tables(conninfo,tables)
                return conninfo.exec("DROP TABLE #{tables}")
        end
	def self.cascade_tables(conninfo,tables)
                return conninfo.exec("DROP TABLE #{tables} CASCADE")
        end
	def self.create_table(conninfo,table_name,columns,oids,table_comments,colum_comments)
		return conninfo.exec("CREATE TABLE #{table_name} (#{columns.chomp(", ")}) 
								WITH (
  									OIDS=#{oids}
				     ); 
				     COMMENT ON TABLE #{table_name} IS 	'#{table_comments}';#{colum_comments}")
	end 
	def self.drop_views(conninfo,views)
                return conninfo.exec("DROP VIEW #{views}")
        end
	def self.create_view(conninfo,view_name,view_definition,view_comments)
		return conninfo.exec("CREATE VIEW #{view_name} AS #{view_definition}; COMMENT ON VIEW #{view_name} IS '#{view_comments}';")
	end
	def self.drop_sequences(conninfo,sequences)
		return conninfo.exec("DROP SEQUENCE #{sequences}")
	end
	def self.create_sequence(conninfo,sequence_name,increment,minvalue,maxvalue,start,cache,cycle,sequence_comments)
		return conninfo.exec("CREATE SEQUENCE #{sequence_name} INCREMENT #{increment}  MINVALUE #{minvalue}  MAXVALUE #{maxvalue} START #{start}  CACHE #{cache}  #{cycle};COMMENT ON SEQUENCE #{sequence_name} IS '#{sequence_comments}';")
	end
	def self.drop_functions(conninfo,functions)
		return conninfo.exec("DROP FUNCTION #{functions}")
	end
	def self.create_function(conninfo,function_name,argumentsq,returns,returns_type,new_definition,language,properties,execution_cost,function_comments)
		return conninfo.exec("CREATE FUNCTION #{function_name} ( #{argumentsq.chomp(", ")} ) RETURNS #{returns} #{returns_type} AS #{new_definition} LANGUAGE #{language} #{properties} COST #{execution_cost}; COMMENT ON FUNCTION #{function_name}(#{argumentsq.chomp(", ")}) IS '#{function_comments}';")
	end
	def self.insert_value(conninfo,schematype,table,collums,div_query,min_query)
		return conninfo.exec("INSERT INTO #{schematype}.#{table} (#{collums.chomp(", ")}) VALUES ('#{div_query.slice!(0..min_query.length-1)}');")
	end
	def self.image(conninfo)
		return conninfo.exec("SELECT img FROM cover")
	end
end
