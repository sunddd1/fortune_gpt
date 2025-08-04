# frozen_string_literal: true

module FortuneGPT
  class UserFortune < ::ActiveRecord::Base
    self.table_name = 'fortune_gpt_user_fortunes'

    belongs_to :user
    belongs_to :fortune,
               class_name: 'FortuneGPT::Fortune',
               foreign_key: 'fortune_gpt_fortune_id'

    validates :user_id, uniqueness: { scope: :picked_on }
  end
end
