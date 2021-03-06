class UsersController < ApplicationController
    
    get '/signup' do 
        if !logged_in?
            erb :'users/signup'
        else
           redirect to '/goals'
        end
    end

    post '/signup' do 
        if params[:password].length < 5 || params[:password] == "" || params[:username] == ""
            redirect to '/signup'
        else 
            @user = User.new(username: params[:username], password: params[:password])
            @user.save
            session[:user_id] = @user.id 
            redirect to '/goals'
        end
    end

    get '/login' do 
        if !logged_in?
            erb :'/users/login'
        else 
            redirect to '/goals'  
        end
    end

    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to "/goals" #this is goals show page (homepage)
        else
          redirect to '/login'
          #flash alert: please try again
        end
    end

    get '/logout' do 
        if logged_in?
            session.destroy
            redirect to '/'
            #flash message
        else
            redirect to '/'
        end
    end


end