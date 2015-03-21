class Person < ActiveRecord::Base

  belongs_to :job

  has_many :catalogs

  has_many :pictures

  validates :job_id, presence: true

  validates :position, numericality: {
    only_integer:             true,
    greater_than_or_equal_to:    0,
    less_than:                 100
  }

  rails_admin do
    weight 3

    list do
      field :job
      field :name
      field :position
      field :active
    end

    edit do
      field :job_id, :enum do
        enum_method do
          :job_id_enum
        end
      end
      field :name
      field :position do
        default_value 0
      end
      field :active
    end
  end

  protected

  def job_id_enum
    Job.all.map {|c| [c.name, c.id]}
  end

end
