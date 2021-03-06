class DishesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def index
  end

  def new
    @dish = Dish.new
    @dish.ingredients.build
  end

  def show
    @dish = Dish.find(params[:id])
  end

  def create
    @dish = current_user.dishes.build(dish_params)
    if @dish.save
      flash[:success] = "レシピを登録しました！"
      redirect_to dish_path(@dish)
    else
      render 'dishes/new'
    end
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update_attributes(dish_params)
      flash[:success] = "レシピ情報を更新しました！"
      redirect_to @dish
    else
      render 'edit'
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    if current_user.admin? || current_user?(@dish.user)
      @dish.destroy
      flash[:success] = "レシピを削除しました！"
      redirect_to request.referrer == user_url(@dish.user) ? user_url(@dish.user) : root_url
    else
      flash[:danger] = "他の人のレシピは削除できません！"
      redirect_to root_url
    end
  end

  private

    def dish_params
      params.require(:dish).permit(:name, :description, :portion,
                                   :reference, :cooking_time, :popularity, :picture,
                                   ingredients_attributes: [:id, :name, :quantity])
    end

    def correct_user
      @dish = current_user.dishes.find_by(id: params[:id])
      redirect_to root_url if @dish.nil?
    end
end
