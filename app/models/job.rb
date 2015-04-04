class Job < ActiveRecord::Base

  has_many :people, dependent: :destroy

  has_many :pictures

  validates :position, numericality: {
    only_integer:             true,
    greater_than_or_equal_to:    0,
    less_than:                 100
  }

  rails_admin do
    weight 2

    list do
      field :name
      field :position
      field :active
    end

    edit do
      field :name
      field :position do
        default_value 0
      end
      field :active do
        default_value true
      end
    end
  end

end
