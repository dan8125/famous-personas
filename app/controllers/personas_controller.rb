class PersonasController < ApplicationController

  def index
    @personas = [
      Persona.find_by(name: "Queen Elizabeth"),
      Persona.find_by(name: "Spongebob"),
      Persona.find_by(name: "Carl Jung")
    ]
  end

  def show
    @persona = Persona.find(params[:id])
  end

  private

  # for the user to create new personas in the future
  def persona_params
    params.require(:persona).permit(:name)
  end

end
