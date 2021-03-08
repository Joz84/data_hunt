class PagesController < ApplicationController
  ORDERED_METHODS = {
    data_hacker: [:city_number],
    art_dealers: [:city1, :city2, :city3],
    news_item: [:news_item_url],
    inside_clue: [:google_image_title],
    great_trip: [:notion_url],
    fake_friend: [:friend1, :friend2, :friend3, :friend4, :friend5],
    bad_move: [:location],
    ultimate_shovel: [],
    final_treasure: [],
  }

  skip_before_action :authenticate_user!, only: [:home, :legal]
  before_action :set_result, except: [:home, :legal]
  def home
    if current_user
      redirect_to data_hacker_path
    else
      redirect_to new_user_registration_path
    end
  end

  def data_hacker
    @current_method = __method__
    set_methods
  end

  def art_dealers
    @current_method = __method__
    play_validations
  end

  def news_item
    @current_method = __method__
    play_validations
  end

  def inside_clue
    @current_method = __method__
    play_validations
  end

  def great_trip
    @current_method = __method__
    play_validations
  end

  def fake_friend
    @current_method = __method__
    play_validations
  end

  def bad_move
    @current_method = __method__
    play_validations
  end

  def ultimate_shovel
    @current_method = __method__
    play_validations
  end

  def final_treasure
  end

  def legal
  end

  private

  def set_result
    @result = Result.new(result_params)
  end

  def set_methods
    @current_method_index = ORDERED_METHODS.keys.find_index(@current_method)
    @previous_method = ORDERED_METHODS.keys[@current_method_index - 1]
    @next_method = ORDERED_METHODS.keys[@current_method_index + 1]
    @searched_attrs = ORDERED_METHODS[@current_method]
    @next_path = eval("#{@next_method}_path")
  end

  def play_validations
    set_methods
    unless @result.valid_for?(result_params.keys)
      flash[:alert] = "Mauvaise réponse!!!"
      @searched_attrs = ORDERED_METHODS[@previous_method]
      @next_path = eval("#{@current_method}_path")
      render @previous_method
    end
    @result = Result.new
  end

  def result_params
    if params[:result]
      params.require(:result).permit(
        :city_number,
        :city1, :city2, :city3,
        :news_item_url,
        :google_image_title,
        :notion_url,
        :friend1, :friend2, :friend3, :friend4, :friend5,
        :location
        )
    else
      {}
    end
  end
end
