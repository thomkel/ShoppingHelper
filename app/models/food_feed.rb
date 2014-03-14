class FoodFeed < ActiveRecord::Base

	validates :title, :presence => true

	belongs_to :user

	after_create :check_video
	after_create :populate_url
	after_create :populate_image

	def check_video
		# if url.blank and !image.blank, assume user put url in wrong location
		if self.feed_type == "video"
			check_video_url
			check_url_format
		end

		self.image = "http://www.standwithus.com/images/Play-icon2.png"
		self.save
	end

	def check_video_url
		# if url.blank and !image.blank, assume user put url in wrong location
		if self.url.blank? && !self.image.blank?
			self.url = self.image
			self.image = ""
			# self.save
		# if both field blanks, copy default video
		elsif (self.url.blank? && self.image.blank?) || !self.url.include?("youtu")
			self.url = "//www.youtube.com/embed/kATDHi2M32Y"
			# self.save
		end
	end

	def check_url_format
		if !self.url.include?("embed")
			# self.url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
			# youtube_id = $5
			# self.url = "//www.youtube.com/embed/#{ youtube_id }"
			if self.url[/youtu\.be\/([^\?]*)/]
				youtube_id = $1
			else
			    # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
			    self.url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
			    youtube_id = $5
			end		
				
			self.url = "//www.youtube.com/embed/#{ youtube_id }"
		end

		if !self.url.start_with?("//")
			self.url = "//" + self.url
		end

		# self.save
	end

	def populate_url
		if self.url.blank? && (self.feed_type == "article") 
			self.url = "http://www.goodreads.com/author/quotes/1124.Anthony_Bourdain"
			self.save	
		end
	end

	def populate_image
		if self.image.blank? && (self.feed_type == "article" || self.feed_type == "image")
			self.image = "http://www.livingwithjuvenilearthritis.com/wp-content/uploads/2013/12/Spam-Can.jpg"
			self.save
		end
	end
end
