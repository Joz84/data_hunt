class PagesController < ApplicationController
  ORDERED_METHODS = {
    data_hacker: [
      {input: :city_number,
      label: "Dans combien de villes des montres de valeur ont été volées?"}],
    art_dealers: [
      {input: :city1, label: "Ville centrale"}, {input: :city2, label: "Ville centrale"}, {input: :city3, label: "Ville centrale"}],
    news_item: [{
      input: :news_item_url,
      label: "Quelle est l'url du document que vous avez trouvé dans la base de données?"
    }],
    inside_clue: [{
      input: :google_image_title,
      label: "Quel est le nom du bateau?",
    }],
    great_trip: [{
      input: :notion_url,
      label: "Quelle est l'url du document que vous avez trouvé dans la base de données?",
    }],
    fake_friend: [
      {input: :friend1, label: "1er marin le plus virulent (avec le score le plus proche de 0)"},
      {input: :friend2, label: "2ème marin le plus"},
      {input: :friend3, label: "3ème marin le plus virulent"},
      {input: :friend4, label: "4ème marin le plus virulent"},
      {input: :friend5, label: "marin le moins virulent (avec le score le plus proche de 100) "} ],
    bad_move: [{
      input: :location,
      label: "Quel est l'animal le plus présent sur le spot de plongée dans lequel le boulet est tombé?",
    }],
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
