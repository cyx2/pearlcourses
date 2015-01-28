# == Schema Information
#
# Table name: ratings
#
#  id                  :integer          not null, primary key
#  rating              :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  prefix              :string
#  course_number       :integer
#  courseid            :integer
#  hwyesno             :boolean
#  profqual            :integer
#  taqual              :integer
#  lecturequal         :integer
#  recitationqual      :integer
#  recitationreqdyesno :boolean
#  hwdiff              :integer
#  examdiff            :integer
#  examyesno           :boolean
#  lecturereqdyesno    :boolean
#  materialdiff        :integer
#  projyesno           :boolean
#  projdiff            :integer
#  prelimyesno         :boolean
#  prelimdiff          :integer
#

class Rating < ActiveRecord::Base	
	belongs_to :user
	# belongs_to :cornellclass

	validates :rating, numericality: { :greater_than_or_equal_to => 0 }
	validates :rating, :profqual, :taqual, :lecturequal, :recitationqual, :hwdiff, :examdiff, :materialdiff, :projdiff, :prelimyesno, :prelimdiff, numericality: { :less_than_or_equal_to => 5 }
	validates :rating, :prefix, :course_number, presence: true	

	def showclass
		Cornellclass.where(courseid: self.courseid)		
	end
end
