require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Mahihi", email: "mahihi@email.com")
    @recipe = Recipe.create(name: "Vegetable Soup", description: "Mete los vegetales en agua durante ebullición", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken Sautee", description: "Some very awesome 'sautee' food thing")
    @recipe2.save
  end
  
  
  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
  
end
