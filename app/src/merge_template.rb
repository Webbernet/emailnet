
class MergeTemplate
  def initialize(template, merge_fields)
    @template = template
    @merge_fields = merge_fields
  end

  def run
    template = @template
    @merge_fields.each do |k, v|
      key      = "{{#{k.to_s}}}"
      template = template.gsub(key, v.to_s)
    end
    template
  end
end