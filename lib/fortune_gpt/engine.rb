# frozen_string_literal: true

module FortuneGPT
  class Engine < ::Rails::Engine
    engine_name "fortune_gpt"
    isolate_namespace FortuneGPT

    initializer "fortune_gpt.assets" do |app|
      app.config.assets.precompile += %w[fortune-display.js]
    end
  end
end

FortuneGPT::Engine.routes.draw do
  get "/fortune" => "fortune#index"
end
