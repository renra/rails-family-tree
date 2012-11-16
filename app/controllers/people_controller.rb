class PeopleController < ApplicationController
  load_and_authorize_resource

  def new
    raise @person.to_yaml
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    #TODO: add model level callbacks
    @person.destroy
  end
end
