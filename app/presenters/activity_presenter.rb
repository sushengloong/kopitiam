class ActivityPresenter < SimpleDelegator
  def initialize activity, view
    super view
    @activity = activity
  end

  def render_activity
    render_partial
  end

  def render_partial
    locals = { activity: @activity, presenter: self }
    locals[@activity.trackable_type.underscore.to_sym] = @activity.trackable
    render partial: partial_path, layout: 'activities/activity_layout', locals: locals
  end

  def partial_path
    partial_paths.detect do |path|
      lookup_context.template_exists? path, nil, true
    end || raise("No partial found for activity in #{partial_paths}")
  end

  def partial_paths
    [
      "activities/#{@activity.trackable_type.underscore}/#{@activity.action}",
      "activities/#{@activity.trackable_type.underscore}",
      "activities/activity"
    ]
  end
end
