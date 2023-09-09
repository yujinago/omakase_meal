class RecipeCategoriesController < ApplicationController
  
  def create
    @recipe_categories = []
    results = RakutenWebService::Recipe.large_categories
    results.each do |result|
      recipe_category = RecipeCategory.new(cook(result))
      @recipe_categories << recipe_category
    end
    @recipe_categories.each do |recipe_category|
      unless RecipeCategory.exists?(name: recipe_category.name)
        recipe_category.save
      end
    end
    redirect_to new_recipe_path
  end
  
  private
  
  def cook(result)
    name = result["categoryName"]
    {
      name: name
    }
  end
  
  
end
