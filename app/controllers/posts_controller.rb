class PostsController < ApplicationController
  
	def create 
		@post = current_user.posts.new(content: posts_params[:content], organisation_id: posts_params[:organisation_id],organisation_post: true)

		if @post.save 
			
			redirect_to @post.organisation


		else 
			flash[:danger] = 'Error posting status'
			render template: "organisations/failed"
		end
	end 

	def edit
	  @post = Post.find(params[:id])
	end 

  def update
  	@post = Post.find(params[:id])
  	
	  if @post.update(content: posts_params[:content])

     	redirect_to organisation_path(@post.organisation_id)
        else 
    	flash[:danger] = 'Error updating status'
    	render :edit
    end
  end

 	def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to organisation_path(@post.organisation_id)
  end

	private 

  def posts_params
    params.require(:post).permit(:content, :organisation_id)

 	end 

end 