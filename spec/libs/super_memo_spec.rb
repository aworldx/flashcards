require 'rails_helper'
require './spec/support/test_helpers'

RSpec.configure do |c|
  c.include TestHelpers
end

RSpec.describe SuperMemo do
  context 'super memo' do
    it '.call' do
      params = {
        response_quality: 5,
        repetition_count: 0,
        e_factor: 2.5,
        repetition_interval: 1
      }

      super_memo_check(params, 1, 2.6)
      super_memo_check(params, 6, 2.7)
      super_memo_check(params, 16, 2.8)
      super_memo_check(params, 46, 2.9)

      params[:response_quality] = 4
      super_memo_check(params, 133, 2.9)

      params[:response_quality] = 3
      super_memo_check(params, 367, 2.76)

      params[:response_quality] = 2
      super_memo_check(params, 1, 2.76)
    end
  end
end
