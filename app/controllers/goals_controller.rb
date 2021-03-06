require 'rack-flash'

class GoalsController < ApplicationController
    use Rack::Flash

    get '/goals' do 
        if logged_in?
            @goals = current_user.goals.all
            erb :'goals/index'
        else
            redirect to '/login'
        end
    end

    get '/goals/new' do 
        if logged_in? 
            erb :'/goals/new'
        else
            redirect to '/'
        end
    end

    post '/goals' do 
        successful = params[:successful] ? 1 : 0
        if logged_in? 
            @goal = current_user.goals.build(content: params[:content], date_created: params[:date_created], completion_goal_date: params[:completion_goal_date], successful: successful)
            @goal.save
            redirect to "/goals"
        else 
            redirect to '/'
        end
    end

    get '/goals/:id' do 
        @goal = current_user.goals.find_by_id(params[:id])
        erb :'/goals/show'
    end

    get '/goals/:id/edit' do 
        if logged_in?
            @goal = current_user.goals.find_by_id(params[:id])
            if @goal && @goal.user == current_user
              erb :'goals/edit'
            else
              redirect to '/goals'
            end
          else
            redirect to '/'
          end
    end

    patch '/goals/:id' do 
        successful = params[:successful] ? 1 : 0
        if logged_in?
            @goal = current_user.goals.find_by_id(params[:id])
            @goal.update(params[:successful?].to_h)
            @goal.content = params[:content]
            @goal.date_created = params[:date_created]
            @goal.completion_goal_date = params[:completion_goal_date]
            @goal.successful = successful
            @goal.save
            flash[:message] = "Your Goal Has Been Updated."
            redirect to '/goals'
        else
            flash[:message] = "Please Login to Continue"
            redirect to '/'
        end
    end

    delete '/goals/:id/delete' do
        if logged_in?
          @goal = current_user.goals.find_by_id(params[:id])
          if @goal && @goal.user == current_user
            @goal.delete
          end
          flash[:message] = "Your Goal Has Been Deleted."
          redirect to '/goals'
        else
          redirect to '/'
        end
      end
end

