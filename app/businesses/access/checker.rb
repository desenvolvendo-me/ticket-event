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
      raise ArgumentError, I18n.t('businesses.access.checker.resource_error') unless [Lesson, Event].include? @resource
      raise ArgumentError, I18n.t('businesses.access.checker.argument_error') unless [:launch, :purchase, :available].include? @check_type

      if @resource.is_a?(Lesson)
        lesson_available?
      elsif @resource.is_a?(Event)
        if @check_type == :purchase
          purchase_available?
        elsif @check_type == :available
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
      @resource.purchase_date <= Time.zone.now
    end
  end
end
