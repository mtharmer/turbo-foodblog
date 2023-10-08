# frozen_string_literal: true

require_relative "../../config/environment"

# Any benchmarking setup goes here...

Benchmark.ips do |x|
  x.report("before") {
    Recipe.all.each do |recipe|
      recipe.comments.each do |comment|
        if comment.user.email
          next
        end
      end
    end
  }
  x.report("better") {
    Recipe.includes(:comments).all.each do |recipe|
      recipe.comments.each do |comment|
        if comment.user.email
          next
        end
      end
    end
  }
  x.report("best") {
    Recipe.includes(comments: :user).all.each do |recipe|
      recipe.comments.each do |comment|
        if comment.user.email
          next
        end
      end
    end
  }

  x.compare!
end
