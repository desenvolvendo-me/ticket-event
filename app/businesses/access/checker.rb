module Access
  class Checker < BusinessApplication
    def initialize(resource, field = :field)
      @resource = resource
      @field = field
    end
    def call
      available?
    end

    private

    def available?
      if @resource.is_a?(Lesson)
        lesson_available?
      elsif @resource.is_a?(Event)
        if @field == :purchase_date
          purchase_available?
        elsif @field == :date
          event_available?
        else
          raise ArgumentError, I18n.t('businesses.access.checker.argument_error')
        end
      else
        raise ArgumentError, I18n.t('businesses.access.checker.resource_error')
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
