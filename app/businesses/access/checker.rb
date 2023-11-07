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
      raise ArgumentError, I18n.t('businesses.access.checker.resource_error') unless [Lesson, Event].include?(@resource.class)
      raise ArgumentError, I18n.t('businesses.access.checker.argument_error') unless [:purchase, :available, :launch].include?(@check_type)
      if @resource.class == Event && ![:purchase, :available].include?(@check_type)
        raise ArgumentError, I18n.t('businesses.access.checker.argument_error')
      end

      case @resource
      when Lesson
        lesson_available?
      when Event
        if @check_type == :purchase
          purchase_available? ? { link: @resource.purchase_link, i18n: I18n.t('views.external.lesson.view_show.purchase_link'), access: true } : { link: @resource.community_link, i18n: I18n.t('views.external.lesson.view_show.community_access'), access: false }
        elsif @check_type == :available
          event_available?
        end
      end
    end

    def lesson_available?
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
