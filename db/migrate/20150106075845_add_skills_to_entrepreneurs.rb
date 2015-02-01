class AddSkillsToEntrepreneurs < ActiveRecord::Migration
  def change
  	add_column :entrepreneurs , :skills, :text
  end
end
