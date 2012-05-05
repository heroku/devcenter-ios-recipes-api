require 'sinatra/base'
require 'sinatra/param'
require 'sequel'

Sequel.extension(:pg_array, :pg_hstore, :pg_hstore_ops)
DB = Sequel.connect(ENV['DATABASE_URL'] || "postgres://localhost/recipes")

class Recipe < Sequel::Model
  plugin :schema
  plugin :json_serializer, naked: true
  
  set_schema do
    primary_key :id

    varchar :name, empty: false
    hstore  :ingredients

    index :ingredients
  end

  create_table unless table_exists?
end

class App < Sinatra::Base
  helpers Sinatra::Param

  before do
    content_type :json
  end

  get '/recipes' do
    param :limit,       Integer,  default: 20, max: 100
    param :offset,      Integer,  default: 0, min: 0
    param :ingredients, Array

    @recipes = Recipe.limit(params[:limit], params[:offset])
    @recipes = @recipes.where(:ingredients.hstore.contain_any(params[:ingredients].pg_array)) if params[:ingredients]

    {recipes: @recipes}.to_json
  end

  post '/recipes' do
    param :name,        String, required: true
    param :ingredients, Hash,   required: true, blank: false

    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients].hstore)

    @recipe.to_json
  end
end
