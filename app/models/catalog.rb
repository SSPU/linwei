class Catalog < ActiveRecord::Base
  after_save :update_pictures_info

  belongs_to :person

  has_many :pictures

  validates :person_id, presence: true

  validates :position, numericality: {
    only_integer:             true,
    greater_than_or_equal_to:    0,
    less_than:                 100
  }

  rails_admin do
    weight 4

    list do
      field :name
      field :person
      field :position
      field :active
    end

    edit do
      field :person_id, :enum do
        enum_method do
          :person_id_enum
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

  def person_id_enum
    Person.all.map {|c| ["#{c.job.name} - #{c.name}", c.id] }
  end

  def update_pictures_info
    self.pictures.each {|p| p.save}
  end

end
