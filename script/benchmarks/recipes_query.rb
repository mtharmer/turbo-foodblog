# frozen_string_literal: true

require_relative "../../config/environment"

# Any benchmarking setup goes here...

Benchmark.ips do |x|
  x.report("before") {
    Recipe.all.each do |recipe|
      recipe.comments.each do |comment|
        # do nothing
      end
    end
  }
  x.report("after") {
    Recipe.includes(comments: :user).all.each do |recipe|
      recipe.comments.each do |comment|
        # do nothing
      end
    end
   }

  x.compare!
end
