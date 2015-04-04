class Person < ActiveRecord::Base
  after_save :update_catalogs_info

  belongs_to :job

  has_many :catalogs, dependent: :destroy

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
      field :active do
        default_value true
      end
    end
  end

  protected

  def job_id_enum
    Job.all.map {|j| [j.name, j.id]}
  end

  def update_catalogs_info
    self.catalogs.each {|c| c.save }
  end

end
