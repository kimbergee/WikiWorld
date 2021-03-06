class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @collaborator = Collaborator.new
    @available_collaborators = User.all.reject { |user| @wiki.users.include?(user) || @wiki.user == user }
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new
    authorize @wiki
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    @collaborator = Collaborator.new
    @available_collaborators = User.all.reject { |user| @wiki.users.include?(user) || @wiki.user == user }
    authorize @wiki
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    # @wiki.user_id = params[:wiki][:user_id]

    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

end
