module MessagesHelper
  def recipients_options(mentor)
    s = ''
    #@users= Entrepreneur.all + Mentor.all
    s << "<option value='#{mentor.fname}' >#{mentor.lname}</option>"
    s.html_safe
  end
end