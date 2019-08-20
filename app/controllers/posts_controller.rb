class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  protect_from_forgery prepend: true, with: :exception
  
  def index 

    @user = User.find(params[:user_id])
    @posts = Post.all.with_attached_images
    @post = Post.new
  end
  
  def new 
  	@user = User.find(params[:user_id])
  	@post = Post.new
  end
  
  def create
  	@user = User.find(params[:user_id])
  	@post =@user.posts.new(text: params[:post][:text])
    if params[:post][:images]
      @post.images.attach(params[:post][:images])
    end

    respond_to do |format|
    	if @post.save
        format.html { redirect_to user_post_path(@user, @post), notice: 'User was successfully created.' }
        format.js
        format.json { render json: @post, status: :created, location: @post}
    	else
    		render "not saved"
    	end
    end
  end
  
  def show 
 	  @user =  User.find_by(id:params[:user_id])
  	@post = Post.find_by(id:params[:id])
  	@comment =@post.comments
  end 


  def edit
  	@post = Post.find_by(id:params[:id])
  end 
  


  def update
  	 	@post = Post.find(params[:id])
      respond_to do |format|
    	 	if @post.update_attributes(posts_params)
    	 		 format.html { redirect_to user_post_path(@post) }
           format.js
           format.json { render json: @post, status: :update , location: @post}
        else
           render "not updated"
    	 	end
      end
  end
  
  def destroy
  	@post = Post.find(params[:id])
      respond_to do |format|
    	 	if @post.destroy
    	 	   format.html { redirect_to '/welcome/' }
           format.js
           format.json { render json: @post, status: :destroy , location: @post}
        else
           render "not deleted"
        end
      end
  end 
  
  private
  	def posts_params
  		params.require(:post).permit(:text, images:[])
  	end 

end