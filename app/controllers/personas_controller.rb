class PersonasController < ApplicationController
  def index
    @personas = Persona.all
  end

  private

  def persona_params
    params.require(:persona).permit(:name, :photo)
  end
end
