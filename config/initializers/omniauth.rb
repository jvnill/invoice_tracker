Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,   ENV['GITHUB_INVOICE_TRACKER_KEY'],   ENV['GITHUB_INVOICE_TRACKER_SECRET']
  provider :linkedin, ENV['LINKEDIN_INVOICE_TRACKER_KEY'], ENV['LINKEDIN_INVOICE_TRACKER_SECRET']
end
