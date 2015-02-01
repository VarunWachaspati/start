class ExtraFieldsToEntrepreneurs < ActiveRecord::Migration
  def change
  		add_column :entrepreneurs , :bio, :text 
		add_column :entrepreneurs , :google, :string
		add_column :entrepreneurs , :fb, :string
		add_column :entrepreneurs , :github, :string
  		add_column :entrepreneurs , :pic_file_name, :string 
		add_column :entrepreneurs , :pic_content_type, :string
		add_column :entrepreneurs , :pic_file_size, :string
		add_column :entrepreneurs , :pic_updated_at, :string
		add_column :entrepreneurs , :education, :text
		add_column :entrepreneurs , :linkedin, :string
		add_column :entrepreneurs , :phone, :string
  end
end