class CandidatesController < ApplicationController
  before_action :find_candidate, only: [:show, :edit, :update, :destroy, :vote]
  
  def index
    @candidates = Candidate.all
  end

  def show
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    
    if @candidate.save
    #   flash[:notice] = "Candidate created"
      redirect_to '/candidates', notice: 'Candidate created'
    else
    # 借new這個頁面再渲染一次  
      render :new 
    end
  end

  def edit
  end

  def update
    if @candidate.update(candidate_params)
        flash[:notice] = "Candidate updated"
        redirect_to '/candidates'
    else
        render :edit 
    end
  end

  def destroy    
    VoteLog.where(candidate_id: params[:id]).destroy_all
    @candidate.destroy

    flash[:notice] = "Candidate deleted"
    redirect_to '/candidates'    
  end

  def vote
    find_candidate
    # @candidate.votes += 1

    # VoteLog.create(candidate: @candidate, ip_address: request.remote_ip)
    @candidate.vote_logs.create(ip_address: request.remote_ip)

    # @candidate.increment(:votes)
    # @candidate.save
    flash[:notice] = "Voted"
    redirect_to '/candidates'
  end

  private
  def candidate_params
    params.require(:candidate).permit(:name, :party, :age, :politics)   
  end  

  def find_candidate
    @candidate = Candidate.find_by(id: params[:id])
  end
end
