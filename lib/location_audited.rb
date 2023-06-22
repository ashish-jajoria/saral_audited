require 'active_record'

module LocationAudited
  class << self
    attr_accessor :ignored_attributes, :current_user_method, :max_audits, :auditing_enabled
    attr_writer :audit_class

    def audit_class
      @audit_class ||= LocationAudit
    end

    def store
      Thread.current[:audited_store] ||= {}
    end

    def config
      yield(self)
    end
  end

  @ignored_attributes = %w(lock_version created_at updated_at created_on updated_on)

  @current_user_method = :current_user
  @auditing_enabled = true
end

require 'location_audited/location_auditor'
require 'location_audited/location_audit'

::ActiveRecord::Base.send :include, LocationAudited::LocationAuditor

require 'location_audited/location_sweeper'
