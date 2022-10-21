class PostRepository
    class << self
      
      def getPostById(id)
        @post = Post.find(id)
      end
  
      def createPost(post)
        @is_save_post = post.save
      end
      
      def updatePost(post, post_params)
         @is_update_post = post.update(post_params)
      end
      
      def destroyPost(post)
        post.destroy
      end 
  
      def filter(select,current_user)
        if select == "all"
          if current_user.admin_flg
            @posts = Post.all.order("created_at DESC")
          else 
            @posts = Post.where(public_flg: true).or (Post.where(created_user: current_user.id))
          end
        elsif select == "my"
           @posts = Post.where(created_user: current_user.id).order("created_at DESC")
        elsif select == "other"
          @posts = Post.where("created_user <> ?", current_user.id).order("created_at DESC")
        end
      end
      
      def search(search,select,current_user)
        @posts=PostRepository.filter(select,current_user)
        @posts = @posts.where("title LIKE :title or description LIKE :desc", 
        {:title => "%#{search}%", :desc => "%#{search}%"})
      end  
  
    end
  end
  