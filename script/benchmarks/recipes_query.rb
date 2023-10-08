# frozen_string_literal: true

require_relative '../../config/environment'

# Any benchmarking setup goes here...

Benchmark.ips do |x|
  x.report('before') do
    Recipe.find_each do |recipe|
      recipe.comments.each do |comment|
        # do nothing
      end
    end
  end

  x.report('after') do
    Recipe.includes(comments: :user).find_each do |recipe|
      recipe.comments.each do |comment|
        # do nothing
      end
    end
  end

  x.compare!
end
