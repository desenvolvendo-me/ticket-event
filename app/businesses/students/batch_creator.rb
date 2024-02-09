module Students
  class BatchCreator < BusinessApplication
    def initialize(csv_path:)
      @csv_path = csv_path
    end

    def call
      CSV.foreach(@csv_path, headers: true) do |row|
        Students::Creator.call(row.to_hash)
      end
    end
  end
end
