module Access
  class Checker < BusinessApplication
    def initialize(resource, check_type = :launch)
      @resource = resource
      @check_type = check_type
    end

    def call
      available?
    end

    private

    def available?
      raise ArgumentError, I18n.t('businesses.access.checker.resource_error') unless [Lesson, Event]
      raise ArgumentError, I18n.t('businesses.access.checker.argument_error') unless [:purchase_date, :date]

      case @resource
      when Lesson
        lesson_available?
      when Event
        if @check_type == :purchase_date
          purchase_available?
        elsif @check_type == :date
          event_available?
        end
      end
    end

    def lesson_available?
      # TODO: Refatorar para que retorne de forma mais inteligente, sendo assim retornará um hash com 2 opções, ou o link de acesso ou a data de lançamento da aula dependendo da condicional. Ex: "Acessar Ingresso", search_ticket_path
      @resource.launch_datetime <= Time.zone.now
    end

    def event_available?
      @resource.date > Time.zone.now
    end

    def purchase_available?
      @resource.purchase_date < Time.zone.now
    end
  end
end
