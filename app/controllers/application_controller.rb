class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include SessionsHelper
  
  before_filter :load_news
  
  
  def deny_access_for_non_admins
    if !admin?
      flash[:error] = "You are not authorized to view this page."
      redirect_to root_path
    end
  end
  
  def load_news
    @recent_news_posts = NewsPost.limit(5)
  end
  
  def register_mailchimp_user_for_newsletter(first_name, last_name, email)
    register_mailchimp_user(first_name, last_name, email, "b1abc6bdf8")
  end
  
  def register_mailchimp_user(first_name, last_name, email, list_id)
    mailchimp_api = Mailchimp::API.new(ENV["MAILCHIMP_API_KEY"])
    Rails.logger.info("Registering for mailchimp...")
    Rails.logger.info(
      mailchimp_api.listSubscribe({ :id => list_id, 
                                  :email_address => email, 
                                  :merge_vars => {"FNAME" => first_name, "LNAME" => last_name }, 
                                  :double_optin => false} )
                                  )
  end
end
