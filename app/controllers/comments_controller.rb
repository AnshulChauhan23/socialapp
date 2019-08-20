class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @comments= Comment.all
   
  end
  
  def new 
  	@post =Post.find(params[:post_id])
  	@user = User.find_by(id:params[:user_id])
  	@comment = Comment.new
  end
  
  def create 
  	@post =Post.find_by(id:params[:post_id])
  	@user = User.find_by(id:params[:user_id])
    @comment = @post.comments.new(text:params[:comment][:text],user_id:params[:user_id])
     respond_to do |format|
    	if @comment.save
         format.html { redirect_to user_post_path(@user, @post, @comment), notice: 'User was successfully created.' }
    		 format.js
         format.json { render json: @comment, status: :created, location: @comment }
    	else
    		render 'can not saved'
    	end
    end
  end
  
  def show 
  end 
  
  def edit
    @post =Post.find_by(id:params[:post_id])
  	@comment = Comment.find(params[:id])
  end 
  
  def update

  	 @comment = Comment.find(params[:id])
  	 if @comment.update_attributes(comments_params)
  	 	redirect_to welcome_index_path
  	 else
  	 	render 'not updated'
  	 end

  end
  
  def destroy
  	 @comment = Comment.find(params[:id])
     respond_to do |format|
    	 if @comment.destroy
    	 	format.html {redirect_to welcome_index_path }
        format.js
        format.json { render json: @comment, status: :created, location: @comment }
    	 else
    	 	render 'not updated'
    	 end
      end 
  end 
  
  private
	def comments_params
		params.require(:comment).permit!
	end

end
