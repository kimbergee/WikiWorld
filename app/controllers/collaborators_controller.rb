class CollaboratorsController < ApplicationController
  include Pundit

  # def new
  #   authorize @wiki
  #   @wiki = Wiki.find(params[:id])
  #   @collaborator = Collaborator.new
  # end

  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @collaborator.user_id = params[:collaborator][:user_id]
    @collaborator.wiki_id = params[:wiki_id]

    if @collaborator.save
      flash[:notice] = "New collaborator added."
      redirect_to @wiki
    else
      flash[:alert] = "There was a problem saving the collaborator. Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end

  def show
    @collaborator = Collaborator.find(params[:id])
  end

  def destroy
    # authorize @wiki
    @wiki = Wiki.friendly.find(params[:id])
    @collaborator = @wiki.collaborators.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator removed."
    else
      flash[:alert] = "There was a problem removing the collaborator. Please try again."
    end

    redirect_to @wiki
  end

end
