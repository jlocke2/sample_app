class PicturesController < ApplicationController
	def index
	end

	def show
		@user = User.find_by(user_name: params[:id])
		@pictures = current_user.pictures.paginate(page: params[:page])
	end

	def new
	end

	def create
      @user = User.find_by(user_name: params[:id])
      @picture = current_user.pictures.build(picture_params)
      if @picture.save
      	redirect_to picture_path(current_user)
      else
      redirect_to root_url
      end
	end

	def edit
	end

	def update
	end

	def destroy
		
	end
private
def picture_params
  	params.require(:picture).permit(:name, :description, :image)
  end

  def correct_user
      @user = User.find_by(user_name: params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
