OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOKID'], ENV['FACEBOOKSECRET'], {:scope => 'email', :display => 'popup', :info_fields => 'name,email',:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
   
end