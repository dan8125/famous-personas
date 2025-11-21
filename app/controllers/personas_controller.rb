class PersonasController < ApplicationController

  def index
    @personas = Persona.all
    @persona = Persona.new
  end

  def show
    @persona = Persona.find(params[:id])
  end

  def create
    @persona = Persona.new(persona_params)

    builder = PersonaBuilder.new(@persona.name)
    result = builder.build

    unless result[:success]
      return render json: { error: result[:error] }, status: :unprocessable_entity
    end

    @persona.bio = result[:bio]
    @persona.greeting = result[:greeting]

    persona_file = URI.parse(result[:image_url]).open
    @persona.photo.attach(io: persona_file, filename: "#{@persona.name}.jpg", content_type: "image/jpg")

    if @persona.save
      render json: { redirect_url: persona_path(@persona) }
    else
      render json: { error: @persona.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # for the user to create new personas in the future
  def persona_params
    params.require(:persona).permit(:name, :image_url)
  end

end
