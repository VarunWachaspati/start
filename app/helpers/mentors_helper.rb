module MentorsHelper

   def correct_mentor_user
       @temp = Users.find_by(email: current_user.email)
       if @temp.type="Entrepreneur"
          return false
       elsif @temp.type="Student"
          return false
         
       else
         
          @mentor = Mentor.find(params[:id])
          if @mentor==current_user
             return true
          else
             return false
          end
       end          
  end

end
