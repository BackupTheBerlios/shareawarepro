class ForumthemesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @forumthemes_pages, @forumthemes = paginate :forumthemes, :per_page => 10
  end

  def show
    @theme = Forumtheme.find(params['id'])
  end

  def new
    @forumthemes = Forumtheme.new
    @folder_id = params['folder_id']
  end

  def create
    @forumtheme = Forumtheme.new(params[:forumthemes])
    if @forumtheme.save
      flash[:notice] = 'Forumtheme was successfully created.'
      redirect_to :controller => 'forumfolders', :action => 'show', :id => @forumtheme.forumfolder_id
    else
      render :action => 'new'
    end
  end

  def edit
    @forumthemes = Forumtheme.find(params[:id])
  end

  def update
    @forumthemes = Forumtheme.find(params[:id])
    if @forumthemes.update_attributes(params[:forumthemes])
      flash[:notice] = 'Forumthemes was successfully updated.'
      redirect_to :action => 'show', :id => @forumthemes
    else
      render :action => 'edit'
    end
  end

  def destroy
    @myfolder_id = Forumtheme.find(params[:id]).forumfolder_id
    Forumtheme.find(params[:id]).destroy
    redirect_to :controller => 'forumfolders', :action => 'show', :id => @myfolder_id
  end
end
