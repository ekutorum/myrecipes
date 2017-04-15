require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Mahihi", email: "mahihi@email.com",
                          password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Vegetable Soup", description: "Mete los vegetales en agua durante ebullición", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken Sautee", description: "Some very awesome sautee food thing")
    @recipe2.save
  end
  
  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname.capitalize, response.body
  end


end
