module ResponsesHelper
  def yes_pct(yes_count, no_count)
    return pct(yes_count, no_count)
  end
  def no_pct(yes_count, no_count)
    return pct(no_count, yes_count)
  end
  def pct(numerator, denominator)
    return nil if numerator.nil? || denominator.nil?
    return nil if numerator + denominator == 0
    number_to_percentage((numerator.to_f / (numerator + denominator)) * 100, precision: 1)
  end
end
