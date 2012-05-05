require './app'

task :seed do
  Recipe.create(name: "Fried Chicken", ingredients: {
    "chicken (broiler/fryer)" => "1 whole",
    "low fat buttermilk" => "2 cups",
    "kosher salt" => "2 tablespoons",
    "Hungarian paprika" => "2 tablespoons",
    "garlic powder" => "2 teaspoons",
    "cayenne pepper" => "1 teaspoon"
    }.to_hstore)

  Recipe.create(name: "40 Cloves and a Chickent", ingredients: {
    "chicken (broiler/fryer)" => "1 whole",
    "olive oil" => "1/2 cup plus 2 tablespoons",
    "fresh thyme" => "10 sprigs",
    "garlic" => "40 peeled cloves",
    "salt and pepper" => nil
    }.to_hstore)
end