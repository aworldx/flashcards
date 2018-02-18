require 'rails_helper'

RSpec.describe SuperMemo do
  context 'super memo' do
    it '.call' do
      params = {
        response_quality: 5,
        repetition_count: 0,
        e_factor: 2.5,
        repetition_interval: 1
      }

      sm = SuperMemo.new(params)
      params.merge!(sm.call)

      expect(params[:repetition_interval]).to eql(1)
      expect(params[:e_factor]).should be_within(0.01).of(2.6)

      sm = SuperMemo.new(params)
      params.merge!(sm.call)

      expect(params[:repetition_interval]).to eql(6)
      expect(params[:e_factor]).should be_within(0.01).of(2.7)

      sm = SuperMemo.new(params)
      params.merge!(sm.call)

      expect(params[:repetition_interval]).to eql(16)
      expect(params[:e_factor]).should be_within(0.01).of(2.8)

      sm = SuperMemo.new(params)
      params.merge!(sm.call)

      expect(params[:repetition_interval]).to eql(46)
      expect(params[:e_factor]).should be_within(0.01).of(2.9)

      sm = SuperMemo.new(params)
      params.merge!(sm.call)
      params[:response_quality] = 4

      expect(params[:repetition_interval]).to eql(133)
      expect(params[:e_factor]).should be_within(0.01).of(2.9)

      sm = SuperMemo.new(params)
      params.merge!(sm.call)
      params[:response_quality] = 3

      expect(params[:repetition_interval]).to eql(367)
      expect(params[:e_factor]).should be_within(0.01).of(2.76)
    end
  end
end

# context 'when user translates cards' do
  #   it 'should increase review date' do
  #     Timecop.freeze(Time.now) do
  #       try_translate(card, 1.days, 'meat')
  #       try_translate(card, 6.days, 'meat')
  #       # 2.8 * 6
  #       try_translate(card, 16.days, 'meat')
  #       # 2.9 * 16
  #       try_translate(card, 46.days, 'meat')
  #       # 2.9 * 46
  #       try_translate(card, 133.days, 'meaG')
  #       # 2.76 * 133
  #       try_translate(card, 367.days, 'maeG')
  #     end
  #   end
  # end

  # context 'when user translates card wrongly repetition interval must back to 1' do
  #   it 'should reduce review date' do
  #     Timecop.freeze(Time.now) do
  #       try_translate(card, 1.days, 'meat')
  #       try_translate(card, 6.days, 'meat')
  #       try_translate(card, 16.days, 'meat')
  #       # back to 1
  #       try_translate(card, 1.days, 'foo')
  #       try_translate(card, 6.days, 'meat')
  #     end
  #   end
