Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,        ENV['GITHUB_INVOICE_TRACKER_KEY'],   ENV['GITHUB_INVOICE_TRACKER_SECRET']
  provider :linkedin,      ENV['LINKEDIN_INVOICE_TRACKER_KEY'], ENV['LINKEDIN_INVOICE_TRACKER_SECRET']
  provider :google_oauth2, ENV['GOOGLE_INVOICE_TRACKER_KEY'],   ENV['GOOGLE_INVOICE_TRACKER_SECRET']
end
