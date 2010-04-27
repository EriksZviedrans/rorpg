class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string :typec
	end
execute "INSERT INTO contents (typec) VALUES ('abstime')"
execute "INSERT INTO contents (typec) VALUES ('aclitem')"
execute "INSERT INTO contents (typec) VALUES ('bigint')"
execute "INSERT INTO contents (typec) VALUES ('bit')"
execute "INSERT INTO contents (typec) VALUES ('bit varying')"
execute "INSERT INTO contents (typec) VALUES ('boolean')"
execute "INSERT INTO contents (typec) VALUES ('bytea')"
execute "INSERT INTO contents (typec) VALUES ('char')"
execute "INSERT INTO contents (typec) VALUES ('character')"
execute "INSERT INTO contents (typec) VALUES ('character varying')"
execute "INSERT INTO contents (typec) VALUES ('cid')"
execute "INSERT INTO contents (typec) VALUES ('cidr')"
execute "INSERT INTO contents (typec) VALUES ('circle')"
execute "INSERT INTO contents (typec) VALUES ('date')"
execute "INSERT INTO contents (typec) VALUES ('double precision')"
execute "INSERT INTO contents (typec) VALUES ('gtsvector')"
execute "INSERT INTO contents (typec) VALUES ('inet')"
execute "INSERT INTO contents (typec) VALUES ('integer')"
execute "INSERT INTO contents (typec) VALUES ('interval')"
execute "INSERT INTO contents (typec) VALUES ('macaddr')"
execute "INSERT INTO contents (typec) VALUES ('money')"
execute "INSERT INTO contents (typec) VALUES ('numeric')"
execute "INSERT INTO contents (typec) VALUES ('oid')"
execute "INSERT INTO contents (typec) VALUES ('path')"
execute "INSERT INTO contents (typec) VALUES ('polygon')"
execute "INSERT INTO contents (typec) VALUES ('real')"
execute "INSERT INTO contents (typec) VALUES ('refcursor')"
execute "INSERT INTO contents (typec) VALUES ('regclass')"
execute "INSERT INTO contents (typec) VALUES ('regconfig')"
execute "INSERT INTO contents (typec) VALUES ('regdictionary')"
execute "INSERT INTO contents (typec) VALUES ('regoper')"
execute "INSERT INTO contents (typec) VALUES ('regoperator')"
execute "INSERT INTO contents (typec) VALUES ('regproc')"
execute "INSERT INTO contents (typec) VALUES ('regprocedure')"
execute "INSERT INTO contents (typec) VALUES ('regtype')"
execute "INSERT INTO contents (typec) VALUES ('reltime')"
execute "INSERT INTO contents (typec) VALUES ('smallint')"
execute "INSERT INTO contents (typec) VALUES ('smgr')"
execute "INSERT INTO contents (typec) VALUES ('text')"
execute "INSERT INTO contents (typec) VALUES ('tid')"
execute "INSERT INTO contents (typec) VALUES ('timestamp without time zone')"
execute "INSERT INTO contents (typec) VALUES ('timestamp with time zone')"
execute "INSERT INTO contents (typec) VALUES ('time without time zone')"
execute "INSERT INTO contents (typec) VALUES ('time with time zone')"
execute "INSERT INTO contents (typec) VALUES ('tinterval')"
execute "INSERT INTO contents (typec) VALUES ('tsquery')"
execute "INSERT INTO contents (typec) VALUES ('tsvector')"
execute "INSERT INTO contents (typec) VALUES ('txid_snapshot')"
execute "INSERT INTO contents (typec) VALUES ('uuid')"
execute "INSERT INTO contents (typec) VALUES ('xid')"
execute "INSERT INTO contents (typec) VALUES ('xml')"
  end

  def self.down
    drop_table :contents
    drop_table :encoding
  end
end
