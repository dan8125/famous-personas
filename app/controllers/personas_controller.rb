class PersonasController < ApplicationController
  def index
    @personas = Persona.all
  end
  def show
    @persona = Persona.find(params[:id])
  end

  private
  def persona_params
    params.require(:persona).permit(:name, :photo)
  end
end
