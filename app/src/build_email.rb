class BuildEmail
  def initialize(identifier, merge_fields)
    @identifier = identifier
    @merge_fields = merge_fields
  end

  def run
    template = Emailnet::EmailTemplate.find_by(identifier: @identifier)
    raise 'No template found for email' unless template
    MergeTemplate.new(template.payload_html, @merge_fields).run
  end
end
