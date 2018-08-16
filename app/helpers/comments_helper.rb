module CommentsHelper
 def find_comment comment_id
   if current_user.admin
     Comment.find_by(id: comment_id)
   else
     current_user.comments.find_by(id: comment_id)
   end
 end
end
