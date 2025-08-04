# frozen_string_literal: true

module ::FortuneGPT
  class Engine < ::Rails::Engine
    engine_name 'fortune_gpt'
    isolate_namespace FortuneGPT
  end
end
