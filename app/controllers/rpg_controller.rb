class RpgController < ApplicationController
  def index
    if session[:gold] == nil
      session[:gold] = 0
    end

    if session[:messages] == nil
      session[:messages] = []
    end

    session[:total_golds] = session[:gold].to_i + session[:total_golds].to_i
    @total_golds = session[:total_golds]
    @current_date_time = Time.new
    @current_hour = @current_date_time.hour

    if(@current_hour > 11)
      @hour = @current_hour - 12

      if(@hour == 0)
        @date_time = "(#{@current_date_time.month}/#{@current_date_time.day}/#{@current_date_time.year} 12:#{@current_date_time.min} pm)"
      else
        @date_time = "(#{@current_date_time.month}/#{@current_date_time.day}/#{@current_date_time.year} #{@hour}:#{@current_date_time.min} pm)"
      end
    else
      @date_time = "(#{@current_date_time.month}/#{@current_date_time.day}/#{@current_date_time.year} #{@current_hour}:#{@current_date_time.min} am)"
    end

    if session[:gold] < 0
      session[:messages] << "Entered a casino and lost #{session[:gold]*-1} gold... Ouch! #{@date_time}"
    elsif session[:gold] > 0
      session[:messages] << "Earned #{session[:gold]} gold from the #{session[:building]}! #{@date_time}"
    end

    @activities = session[:messages]
    session[:gold] = 0
    session[:building] = ""
  end

  def new
    if params[:building] == "farm"
      session[:gold] = rand(10..20)
    elsif params[:building] == "cave"
        session[:gold] = rand(5..10)
    elsif params[:building] == "house"
        session[:gold] = rand(2..5)
    elsif params[:building] == "casino"
        if session[:total_golds] < 1
          session[:messages] << "Can't gamble with gold you don't have!"
        else
          session[:gold] = rand(-50..50)
        end
    end

    session[:building] = params[:building]

    redirect_to action: 'index'
  end

  def destroy
    reset_session
    redirect_to :rpg
  end

  def farm
  end

  def cave
  end

  def house
  end

  def casino
  end
end
