require 'rails_helper'
require './spec/support/test_helpers'

RSpec.configure do |c|
  c.include TestHelpers
end

RSpec.describe TranslateQualityChecker do
  context 'translate quality checker' do
    it '.response_quality' do
      translate_quality_check('developer', 'developer', 5)
      translate_quality_check('developer', 'developre', 4)
      translate_quality_check('developer', 'edvelopre', 3)
      translate_quality_check('developer', 'elephant', 0)
    end
  end
end
