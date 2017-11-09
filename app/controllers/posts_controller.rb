class PostsController < ApplicationController
	def create 
		@post = current_user.posts.new(content: posts_params[:content], organisation_id: params[:organisation_id])
		if @post.save
			redirect_to @post.organisation
		else 
			flash[:danger] = 'Error posting status'
			render template: "organisations/failed"
		end
	end 

	def update 
	  @post = Post.find(params[:id])
	  if @post.update(post_params)
     render template: "organisation/show"
        else 
    	flash[:danger] = 'Error updating status'
    	render :edit
    end
  end

 	def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end

  def posts_params
    params.require(:post).permit(:content)

 	end 

end 