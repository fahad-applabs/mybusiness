class VisitorMailer < ActionMailer::Base
  default from: "info@bitesite.ca"
  add_template_helper(ApplicationHelper)
  
  def contact_confirmation(first_name, last_name, customer_email, message)
    
    attachments.inline['emailheader.png'] = File.read(Rails.root.join('app/assets/images/emailheader.png'))
    
    @first_name, @last_name, @message = first_name, last_name, message
    
    mail(:to => customer_email,
         :from => "info@bitesite.ca",
         :subject => "Thanks for contacting BiteSite.ca!")
  end
  
  def contest_confirmation(contestant)
    
    attachments.inline['emailheader.png'] = File.read(Rails.root.join('app/assets/images/emailheader.png'))
    @contestant = contestant
        
    mail(:to => @contestant.email,
         :from => "info@bitesite.ca",
         :subject => "Thanks for entering the Wedding Video Contest 2013")
  end
  
end
