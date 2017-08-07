class ItemsController < ApplicationController
	def destroy
		@item = Item.find(params[:id])
		@item.destroy
		redirect_to :back
	end

	private

	def items_params
      params.require(:list).permit(:id)
    end
end
