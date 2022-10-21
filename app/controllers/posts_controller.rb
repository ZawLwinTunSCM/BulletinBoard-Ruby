class PostsController < ApplicationController
  
  before_action :authorize_admin
  
  def index
   if params[:search].present?
    @posts = PostService.search(params[:search],params[:select],current_user)
   elsif params[:select].present?
    @posts = PostService.filter(params[:select],current_user)
   else
    @posts = PostService.filter("all",current_user)
   end
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create(post_params)
    @post.created_user ||= current_user.id
    @post.user_id ||= current_user.id
    @is_save = PostService.createPost(@post)
    if @is_save
      redirect_to posts_path, notice: 'Post Created Successfully'
    else
      render :new
    end
  end

  def show
    @post = PostService.getPostById(params[:id])
  end

  def edit
    if isCurrentUser(PostService.getPostById(params[:id]).created_user)
      @post = PostService.getPostById(params[:id])
    else
      render file: "#{Rails.root}/public/422.html", layout: false
    end
  end

  def update
    @post = PostService.getPostById(params[:id])
    @post.updated_user ||= current_user.id
    @is_update = PostService.updatePost(@post, post_params)
    if @is_update
      redirect_to posts_path, notice: 'Post Updated Successfully'
    else
      render :edit
    end
  end

  def destroy
    @post = PostService.getPostById(params[:id])
    PostService.destroyPost(@post)
    redirect_to posts_path, notice: 'Post Deleted Successfully'
  end

  def download_csv
    @posts = PostService.filter("all",current_user).reorder('id ASC')
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv(@posts),:filename => "Posts-#{Date.today}.csv" }
    end
  end

  def import_csv
    if (params[:file].nil?)
      redirect_to upload_csv_path, notice: "File is required"
    elsif !File.extname(params[:file]).eql?(".csv")
      redirect_to upload_csv_path, notice: "Wrong File Type"
    else
      error =  PostsHelper.check_header(Constants::POST_CSV_FORMAT_HEADER,params[:file])
      if error.present?
        redirect_to upload_csv_path, notice: error
      else
          file_result = Post.import(params[:file], current_user.id)
          if (file_result == true)
            redirect_to posts_path, notice: "File Imported Successfully"
          else 
            redirect_to upload_csv_path, notice: file_result
          end
      end
    end
  end

  private def post_params
    params.require(:post).permit(:title, :description, :public_flg,:created_user, :updated_user)
  end

end
