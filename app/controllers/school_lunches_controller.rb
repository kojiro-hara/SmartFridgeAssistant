class SchoolLunchesController < ApplicationController
  before_action :set_school_lunch, only: [:show, :edit, :update, :destroy, :speak]

  def index
    @today_lunch = SchoolLunch.today
    @upcoming_lunches = SchoolLunch.upcoming
  end

  def show
  end

  def new
    @school_lunch = SchoolLunch.new
  end

  def edit
  end

  def create
    @school_lunch = SchoolLunch.new(school_lunch_params)

    if @school_lunch.save
      redirect_to @school_lunch, notice: '給食献立が正常に作成されました。'
    else
      render :new
    end
  end

  def update
    if @school_lunch.update(school_lunch_params)
      redirect_to @school_lunch, notice: '給食献立が正常に更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @school_lunch.destroy
    redirect_to school_lunches_url, notice: '給食献立が正常に削除されました。'
  end

  def speak
    audio_file = TextToSpeechService.generate_lunch_announcement(@school_lunch)
    
    send_file audio_file.path,
              filename: "lunch_#{@school_lunch.date.strftime('%Y%m%d')}.wav",
              type: 'audio/wav',
              disposition: 'inline'
  end

  private

  def set_school_lunch
    @school_lunch = SchoolLunch.find(params[:id])
  end

  def school_lunch_params
    params.require(:school_lunch).permit(:date, :main_dish, :side_dish, :soup, :dessert, :calories, :nutrition_info)
  end
end
