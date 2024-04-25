class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_comment, only: [:edit, :update, :destroy]

    def new 
        @comment = Comment.new
    end

    def create 
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.blog_post_id = params[:blog_post_id]
      
        if @comment.save
          redirect_to blog_post_path(params[:blog_post_id]), notice: 'Comment was successfully created.'
        else
          @blog_post = BlogPost.find(params[:blog_post_id])
          render :new, status: :unprocessable_entity
        end
    end
      
    def edit
    end

    def update    
        if @comment.update(comment_params)
          redirect_to blog_post_path(@comment.blog_post_id), notice: 'Comment was successfully updated.'
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @comment.destroy
        redirect_to blog_post_path(params[:blog_post_id]), notice: 'Comment was successfully deleted.'
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end

end
