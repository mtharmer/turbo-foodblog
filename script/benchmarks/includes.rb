# frozen_string_literal: true

require_relative '../../config/environment'

# Any benchmarking setup goes here...

Benchmark.ips do |x|
  x.report('before') do
    Recipe.find_each do |recipe|
      recipe.comments.each do |comment|
        comment.user.email && next
      end
    end
  end

  x.report('better') do
    Recipe.includes(:comments).find_each do |recipe|
      recipe.comments.each do |comment|
        comment.user.email && next
      end
    end
  end

  x.report('best') do
    Recipe.includes(comments: :user).find_each do |recipe|
      recipe.comments.each do |comment|
        comment.user.email && next
      end
    end
  end

  x.compare!
end
