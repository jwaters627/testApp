class ListsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def show
  		@list = List.find(params[:id])
  		@users = @list.users.paginate(page: params[:page])
  		@items = Item.all.where('list_id =' + params[:id].to_s)
  	end

  	def new
  		@list = List.new
  		
  	end

	def create
		@list = List.new
		@list.name = list_params[:name]
		@user = User.find(@current_user.id)
		@user.lists << @list
		@user.save		
		@list.save
  		redirect_to @list
	end

	def edit
  		@list = List.find(params[:id])
	end

	def update
  	@list = List.find(params[:id])
  	@item = Item.new
  	@item.name = list_params[:name]
  	@item.list_id = params[:id]
  	@item.save
  	redirect_to :back
	end

	def share
		@list = List.find(params[:id])
		@people = User.all
	end

  def add
    @list = List.find(params[:id])
    if User.find(params[:userid]).lists.include? @list
      redirect_to :back
      return
    else
      User.find(params[:userid]).lists << @list
      redirect_to :back
    end
  end

	def destroy
		@list = List.find(params[:id])
		@list.destroy
		redirect_to :back
	end

	private

    def list_params
      params.require(:list).permit(:name)
    end
end
