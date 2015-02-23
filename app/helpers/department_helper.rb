module DepartmentHelper
  def departments_for_select
    Department.all.collect { |m| [m.title, m.id] }
  end
end