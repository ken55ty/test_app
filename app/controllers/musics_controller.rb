class MusicsController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

  def search
    if params[:search].present?
      search_results = RSpotify::Track.search(params[:search])
      @musics = search_results.first(8).map do |track|
        {
          id: track.id,
          name: track.name,
          artist: track.artists.first.name,
          cover_image: track.album.images
        }
      end
    else
      @musics = []  # 検索クエリがない場合は空の結果を返す
    end

    render :new
  end

  # GET /musics or /musics.json
  def index
    @musics = Music.all
  end

  # GET /musics/1 or /musics/1.json
  def show
    @music = Music.find(params[:id])
  end

  # GET /musics/new
  def new
    @music = Music.new
  end

  # GET /musics/1/edit
  def edit
  end

  # POST /musics or /musics.json
  def create
    music_params = params.permit( :spotify_music_id, :artist, :title, cover_image: [:url, :height, :width])
    
    # Musicモデルの新しいインスタンスを作成
    @music = Music.new(music_params)


      #Rails.logger.debug @music.errors.full_messages
      if @music.save
        redirect_to @music, notice: "Music was successfully created." 
      else
        render :new, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /musics/1 or /musics/1.json
  def update
    respond_to do |format|
      if @music.update(music_params)
        format.html { redirect_to music_url(@music), notice: "Music was successfully updated." }
        format.json { render :show, status: :ok, location: @music }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /musics/1 or /musics/1.json
  def destroy
    @music.destroy!

    respond_to do |format|
      format.html { redirect_to musics_url, notice: "Music was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music
      @music = Music.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def music_params
      params(:artist, :spotify_track_id, :title, :cover_image)
    end
end
