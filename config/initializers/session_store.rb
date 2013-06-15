# Be sure to restart your server when you modify this file.

# changed session store from :encrypted_cookie_store to :cookie_store
# to resolve an issue after updating to rails 4.0.0.rc2
# refer to http://stackoverflow.com/a/15849479/626687
Kopitiam::Application.config.session_store :cookie_store, key: '_kopitiam_session'
