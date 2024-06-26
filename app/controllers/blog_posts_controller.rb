class BlogPostsController < ApplicationController
    before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @blog_posts = user_signed_in? ? (BlogPost.sorted.get_mine(current_user.id).or(BlogPost.published)) : BlogPost.sorted.published
        @pagy, @blog_posts = pagy(@blog_posts)
    rescue Pagy::OverflowError
        params[:page] = 1
        retry
    end      

    def show 
        @comments = Comment.by_blog_post(@blog_post.id)
    end

    def new 
        @blog_post = BlogPost.new
    end

    def create 
        @blog_post = BlogPost.new(blog_post_params)
        @blog_post.user = current_user
        if @blog_post.save
            redirect_to @blog_post
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @blog_post.update(blog_post_params)
            redirect_to @blog_post
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @blog_post.destroy
        redirect_to root_path
    end

    private
    def blog_post_params
        params.require(:blog_post).permit(:title, :content, :published_at)
    end

    def set_blog_post
        @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : @blog_post = BlogPost.published.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end
end