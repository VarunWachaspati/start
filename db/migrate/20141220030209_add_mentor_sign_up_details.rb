class AddMentorSignUpDetails < ActiveRecord::Migration
  def change
		add_column :mentors , :expertise, :text 
		add_column :mentors , :mentor_interest, :text
		add_column :mentors , :time_devoted_monthly, :integer
		add_column :mentors , :ways_can_help, :text





  end
end
