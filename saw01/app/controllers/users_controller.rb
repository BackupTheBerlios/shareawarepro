class UsersController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @user_pages, @users = paginate :users, :per_page => 10
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash['notice'] = "User was successfully created."
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if ( (@user.login != params[:user]['login']) and (@user.login != '') )
      @user.update_attribute('login',params[:user]['login'])
    end
    if ( (@user.vorname != params[:user]['vorname']) and (@user.vorname != '') )
      @user.update_attribute('vorname',params[:user]['vorname'])
    end
    if ( (@user.nachname != params[:user]['nachname']) and (@user.nachname != '') )
      @user.update_attribute('nachname',params[:user]['nachname'])
    end
    if ( (@user.email != params[:user]['email']) and (@user.email != '') )
      @user.update_attribute('email',params[:user]['email'])
    end
    if ( (@user.beschreibung != params[:user]['beschreibung']) and (@user.beschreibung != '') )
      @user.update_attribute('beschreibung',params[:user]['beschreibung'])
    end
    if ( params['pw1'] != '' )
      if !User.authenticate(params[:user]['login'], params['pwa'])
	flash['notice'] = "Ihr aktuelles Passwort ist falsch!"
	redirect_to :action => 'edit', :id => @user
	return
      end
      if ( params['pw1'] != params['pw2'] )
	flash['notice'] = "Das Passwort muss mit der Wiederholung uebereinstimmen!"
	redirect_to :action => 'edit', :id => @user
	return
      end
      if(flash['notice'] != '')
        @user.update_attribute('password',params['pw1'])
      end
    end
    if(flash['notice'] != '')
      redirect_to :action => 'show', :id => @user
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
