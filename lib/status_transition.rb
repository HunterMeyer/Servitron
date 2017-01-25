module StatusTransition
  module Status
    ACTIVE    = 'Active'.freeze
    DISABLED  = 'Disabled'.freeze
    ERASED    = 'Erased'.freeze
  end

  def self.settings_for(*statuses)
    return settings unless statuses.present?
    settings.select { |status, _| statuses.include? status }
  end

  def self.settings
    {
      active:   { value: Status::ACTIVE,   toggle: :activate },
      disabled: { value: Status::DISABLED, toggle: :disable  },
      erased:   { value: Status::ERASED,   toggle: :erase    }
    }
  end
end
