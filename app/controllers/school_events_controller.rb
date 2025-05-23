class SchoolEventsController < ApplicationController
  before_action :set_school_event, only: [:show, :edit, :update, :destroy, :speak]

  def index
    @school_events = SchoolEvent.order(start_date: :asc)
    @upcoming_events = @school_events.select(&:upcoming?)
    @current_events = @school_events.select(&:current?)
  end

  def show
  end

  def new
    @school_event = SchoolEvent.new
  end

  def edit
  end

  def create
    @school_event = SchoolEvent.new(school_event_params)

    if @school_event.save
      redirect_to @school_event, notice: '行事予定が正常に作成されました。'
    else
      render :new
    end
  end

  def update
    if @school_event.update(school_event_params)
      redirect_to @school_event, notice: '行事予定が正常に更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @school_event.destroy
    redirect_to school_events_url, notice: '行事予定が正常に削除されました。'
  end

  def speak
    audio_file = TextToSpeechService.generate_event_announcement(@school_event)
    
    send_file audio_file.path,
              filename: "event_#{@school_event.id}.wav",
              type: 'audio/wav',
              disposition: 'inline'
  end

  private

  def set_school_event
    @school_event = SchoolEvent.find(params[:id])
  end

  def school_event_params
    params.require(:school_event).permit(:title, :description, :start_date, :end_date, :event_type, :location)
  end
end
