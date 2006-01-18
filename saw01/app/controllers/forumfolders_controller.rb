class ForumfoldersController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
        @forumfolder_pages, @forumfolders = paginate :forumfolders, :per_page => 10
  end
  
  def list_by_ueberfolder
	if(!@params['ueberfolder_id'].nil?)
		@ueberfolder_id = @params['ueberfolder_id']
		@ueberfolders = Forumfolder.find_by_sql "SELECT * FROM forumfolders WHERE id = \"#{@ueberfolder_id}\";"
		@ueberfolder = @ueberfolders[0]
	end
	if(!@params['id'].nil?)
		@ueberfolder = Forumfolder.find(params['id'])
	end
	if(!@ueberfolder.nil?)
		@forumfolder_pages = Paginator.new self, Forumfolder.count, 10, @params['page']
		@forumfolders = Forumfolder.find_by_sql "SELECT i.* FROM forumfolders c, forumfolders i " +
		"WHERE ( c.id = i.ueber_folder_id ) " +
		"AND ( c.id = \"#{@ueberfolder_id}\" ) " +
		"ORDER BY c.ueber_folder_id " +
		"LIMIT 10 " +
		"OFFSET #{@forumfolder_pages.current.to_sql[1]}"
	end
	render_action 'list'
  end

  def show
    if(!@params['ueberfolder_id'].nil?)
		@folder_id = @params['ueberfolder_id']
		@folders = Forumfolder.find_by_sql "SELECT * FROM forumfolders WHERE id = \"#{@ueberfolder_id}\";"
		@folder = @ueberfolders[0]
	end
	if(!@params['id'].nil?)
		@folder = Forumfolder.find(params['id'])
	end
	if(!@folder.nil?)
		@folder_id = @folder.id
		@ueberfolder = Forumfolder.getFolder(@folder.ueber_folder_id)
		#flash['notice'] = "ueberfolder_id: "+@folder.ueber_folder_id.to_s
		@forumfolder_pages = Paginator.new self, Forumfolder.count, 10, @params['page']
		@forumfolders = Forumfolder.find_by_sql "SELECT i.* FROM forumfolders c, forumfolders i " +
		"WHERE ( c.id = i.ueber_folder_id ) " +
		"AND ( c.id = \"#{@folder_id}\" ) " +
		"ORDER BY c.ueber_folder_id " +
		"LIMIT 10 " +
		"OFFSET #{@forumfolder_pages.current.to_sql[1]}"
		@forumthemes = @folder.forumthemes
	end
  end

  def new
    @forumfolders = Forumfolder.new
  end

  def create
    @forumfolders = Forumfolder.new(params[:forumfolders])
    if @forumfolders.save
      flash[:notice] = 'Forumfolder was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @forumfolders = Forumfolder.find(params[:id])
  end

  def update
    @forumfolders = Forumfolder.find(params[:id])
    if @forumfolders.update_attributes(params[:forumfolders])
      flash[:notice] = 'Forumfolder was successfully updated.'
      redirect_to :action => 'show', :id => @forumfolders
    else
      render :action => 'edit'
    end
  end

  def destroy
    Forumfolder.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
