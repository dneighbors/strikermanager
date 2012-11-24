class PrivateLeaguesController < ApplicationController
  # GET /private_leagues
  # GET /private_leagues.json
  def index
    @private_leagues = PrivateLeague.find(:all, :order => "league_id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @private_leagues }
    end
  end

  # GET /private_leagues/1
  # GET /private_leagues/1.json
  def show
    @private_league = PrivateLeague.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @private_league }
    end
  end

  # GET /private_leagues/new
  # GET /private_leagues/new.json
  def new
    @private_league = PrivateLeague.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @private_league }
    end
  end

  # GET /private_leagues/1/edit
  def edit
    @private_league = PrivateLeague.find(params[:id])
  end

  # POST /private_leagues
  # POST /private_leagues.json
  def create
    @private_league = PrivateLeague.new(params[:private_league])

    respond_to do |format|
      if @private_league.save
        format.html { redirect_to @private_league, notice: 'Private league was successfully created.' }
        format.json { render json: @private_league, status: :created, location: @private_league }
      else
        format.html { render action: "new" }
        format.json { render json: @private_league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /private_leagues/1
  # PUT /private_leagues/1.json
  def update
    @private_league = PrivateLeague.find(params[:id])

    respond_to do |format|
      if @private_league.update_attributes(params[:private_league])
        format.html { redirect_to @private_league, notice: 'Private league was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @private_league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /private_leagues/1
  # DELETE /private_leagues/1.json
  def destroy
    @private_league = PrivateLeague.find(params[:id])
    @private_league.destroy

    respond_to do |format|
      format.html { redirect_to private_leagues_url }
      format.json { head :ok }
    end
  end
end
