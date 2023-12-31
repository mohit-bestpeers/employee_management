class EmployeeSerializer < ActiveModel::Serializer
  attributes :employee
  def employee
    {
      id: object.id,
      name: object.name,
      email: object.email,
      package: object.package,
      experience:object.experience
    }
  end
  belongs_to :designation , serializer: DesignationSerializer 
  belongs_to :department, serializer: DepartmentSerializer
  belongs_to :detail, serializer: DetailSerializer
end
