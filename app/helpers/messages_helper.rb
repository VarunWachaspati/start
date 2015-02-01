module MessagesHelper
  def recipients_options
    s = ''
    #@users= Entrepreneur.all + Mentor.all
    Entrepreneur.all do |user|
      s << "<option value='#{user.fname}' >#{user.fname}</option>"
    end
    s.html_safe
  end
end