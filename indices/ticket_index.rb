ThinkingSphinx::Index.define :ticket, :with => :active_record do
  # fields
  indexes subject, :sortable => true
  indexes body

  # attributes
  has staff_id, created_at, updated_at
end
