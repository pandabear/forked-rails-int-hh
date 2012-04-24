ActionMailer::Base.default_url_options[:host] = CONFIG[:host]

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :authentication       => "plain",
  :enable_starttls_auto => true,
  :user_name            => CONFIG[:smtp_username],
  :password             => CONFIG[:smpt_password]
}
if Rails.env.development?
  Mail.register_interceptor(DevelopmentMailInterceptor)
end