class PostService
    class << self

      def getPostById(id)
        @post = PostRepository.getPostById(id)
      end
  
      def createPost(post)
        @is_save_post = PostRepository.createPost(post)
      end
  
      def updatePost(post, post_params)
        @is_update_post = PostRepository.updatePost(post, post_params)
      end       
  
      def destroyPost(post)
        PostRepository.destroyPost(post)
      end         
  
      def search(search,select,current_user)
          @posts = PostRepository.search(search,select,current_user)
      end  

      def filter(select,current_user)
          @posts = PostRepository.filter(select,current_user)
      end
  
    end
end
  