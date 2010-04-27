# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_postgresql_tool_session',
  :secret      => '906d398df757f69d1d770e5235459a5278e8c946ea5c9a14a6c9519fba1db9b31d787017ad680102de98b72dbd171f3fd0d858c9a951c50e6b797faf0c30598c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
