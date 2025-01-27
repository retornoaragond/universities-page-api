# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace "api" do
    namespace "v1" do
      resources :universities, only: %i[index show create update destroy]
    end
  end
end
