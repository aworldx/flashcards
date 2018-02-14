class SuperMemo
  attr_reader :repetition_count, :e_factor, :repetition_interval

  def initialize(params = {})
    @response_quality = params.fetch(:response_quality, 5)
    @repetition_count = params.fetch(:repetition_count, 1)
    @e_factor = params.fetch(:repetition_count, 2.5)
    @repetition_interval = params.fetch(:repetition_count, 1)
  end

  def call
    if @response_quality < 3
      @repetition_count = 1
    else
      @repetition_count += 1
      calculate_e_factor
    end

    calculate_interval
  end

  private

  def calculate_interval
    intervals = { 1 => 1, 2 => 6 }
    @repetition_interval = intervals.fetch(@repetition_count) { @repetition_interval * @e_factor }
  end

  def calculate_e_factor
    @e_factor += (0.1 - (5 - @response_quality) * (0.08 + (5 - @response_quality) * 0.02))
    @e_factor = 1.3 if e_factor < 1.3
  end
end
