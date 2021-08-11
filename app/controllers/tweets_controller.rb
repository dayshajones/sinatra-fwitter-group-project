class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      user = User.find(session[:user_id])
      user.tweets << Tweet.create(content: params[:content])
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  # get '/tweets/new' do

  #     erb :'tweets/new'
  # end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do

    tweet = Tweet.find(params[:id])

    if logged_in? && params[:content] != "" && current_user.tweets.include?(tweet)

      tweet.content = params[:content]
      tweet.save

      redirect "tweets/#{tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do

    tweet = Tweet.find(params[:id])

    if logged_in? && current_user.tweets.include?(tweet)
      tweet.delete
    end

    redirect '/tweets'
  end

  post '/tweets/:id' do


  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'

    else
      redirect '/login'

    end
  end

end
