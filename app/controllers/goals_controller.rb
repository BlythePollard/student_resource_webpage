class GoalsController < ApplicationController

    get '/goals' do 
        if logged_in?
            @goals = Goal.all 
            erb :'goals/show'
        else
            redirect to '/login'
        end
    end

end