class PersonasController < ApplicationController

  def index
    @personas = Persona.all
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
