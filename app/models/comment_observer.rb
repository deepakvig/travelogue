class CommentObserver < ActiveRecord::Observer
 
  def after_create(comment)
    puts "Send email"
  end

end
