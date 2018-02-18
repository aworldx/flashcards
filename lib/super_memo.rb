class SuperMemo
  def initialize(params = {})
    @response_quality = params.fetch(:response_quality, 5)
    @repetition_count = params.fetch(:repetition_count, 1)
    @e_factor = params.fetch(:e_factor, 2.5)
    @repetition_interval = params.fetch(:repetition_interval, 1)
  end

  def call
    result = {}

    if @response_quality < 3
      result[:repetition_count] = 1
      result[:e_factor] = @e_factor
    else
      result[:repetition_count] = @repetition_count + 1
      result[:e_factor] = calculate_e_factor
    end

    result[:repetition_interval] = calculate_interval(result[:repetition_count], result[:e_factor])

    result
  end

  private

  def calculate_interval(repetition_count, e_factor)
    intervals = { 1 => 1, 2 => 6 }
    intervals.fetch(repetition_count) { (@repetition_interval * e_factor).to_i }
  end

  def calculate_e_factor
    e_factor = @e_factor + (0.1 - (5 - @response_quality) * (0.08 + (5 - @response_quality) * 0.02))
    e_factor = 1.3 if e_factor < 1.3
    e_factor
  end
end
