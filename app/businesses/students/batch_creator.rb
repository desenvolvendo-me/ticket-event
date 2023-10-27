module Students
  class BatchCreator < BusinessApplication

    def initialize(csv_path:)
      @csv_path = csv_path
    end

    def call
      CSV.foreach(@csv_path, headers: true) do |row|
        Students::Creator.call(row)
      end
    end
  end
end