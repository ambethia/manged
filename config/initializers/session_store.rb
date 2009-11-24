# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_manged_session',
  :secret      => 'e337ad7593ac9a0b7e6e25a4b3ec517046178f127813877440c676583667361405af8ded224c58e2500d2fe7731546b4bca84e40f56011109bd0bb49d70b6129'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
