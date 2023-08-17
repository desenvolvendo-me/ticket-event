class CreatePactice
  def for_days(num_days, commit_total, student, date = Date.today)
    last_commit_date = date - num_days
    (0..num_days - 1).map do |days_ago|
      commit_date = last_commit_date + days_ago
      Practice.create(commit_date: commit_date, commit_total: commit_total, student: student)
    end
    last_commit_date
  end
end