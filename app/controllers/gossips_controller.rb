class GossipsController < ApplicationController
  def home
  end

  def new
    @gossip = Gossip.new
  end

  def create
    user = current_user
    @gossip = Gossip.new(title: params[:gossip][:title], content: params[:gossip][:content])

    if user.nil?
      redirect_to registration_new_path, alert: "Please log in to create a gossip!"
    else
      @gossip.update!(user_id: user.id)
      if @gossip.save!
        redirect_to gossip_path(@gossip.id), notice: 'New Gossip successfuly created'
      else
        redirect_to new_gossip_path, alert: "Something went wrong. Gossip couldn't be created"
      end
    end
  end

  def show
    if Gossip.where(id: params[:id]).exists?
      @gossip = Gossip.find(params[:id])
      @comment = Comment.new
      @current_user = current_user
      @like = Like.new
    else
      redirect_to root_path, alert: "Sorry, Gossip ##{params[:id]} does not exist"
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if current_user && @gossip.user_id == current_user.id
      @gossip.update!(gossip_params)
      redirect_to gossip_path(@gossip.id)
    else
      flash[:alert] = "Only #{@gossip.user.name} can edit this comment"
      render :edit
    end

  end

  def destroy
    @gossip = Gossip.find(params[:id])
    if current_user && @gossip.user_id == current_user.id
      @gossip.destroy
      redirect_to gossips_path
    else
      flash[:alert] = "Only #{@gossip.user.name} can delete this comment"
      redirect_to gossip_path(@gossip.id)
    end
  end

  def index
    @gossips = Gossip.all
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end
end
