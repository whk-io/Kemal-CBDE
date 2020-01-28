require "kemal"

# TODO: Write documentation for `Kemal`

module Kemal

  get "/" do

    h1_var = "Kemal #{VERSION}"
    render "src/views/main.ecr"
    
  end
  
  Kemal.run
  
end
