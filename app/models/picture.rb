class Picture < ActiveRecord::Base

  before_save :update_person_and_job

  belongs_to :catalog

  belongs_to :person

  belongs_to :job

  validates :catalog_id, presence: true

  validates :position, numericality: {
    only_integer:             true,
    greater_than_or_equal_to:    0,
    less_than:                 100
  }

# Paper Clip
  has_attached_file :asset, styles: {
    small:  "150x150",
    medium: "300x300",
    large:  "600x600"
  }

  validates_attachment :asset, presence: true,
    content_type: {content_type: ["image/jpeg"]},
    size: {in: 0..10.megabytes }

# Rails Admin
  def delete_asset
    self.asset = nil
    self.save
  end

  attr_accessor :delete_asset

  before_validation { self.asset.clear if self.delete_asset == '1' }

  rails_admin do
    weight 1

    list do
      field :job
      field :person
      field :catalog
      field :asset do
        pretty_value do
          bindings[:view].tag(:img, {:src => bindings[:object].asset.url(:small)})
        end
      end
      field :active
      field :position
    end

    edit do
      field :catalog_id, :enum do
        enum_method do
          :catalog_id_enum
        end
      end
      field :name
      field :position do
        default_value 0
      end
      field :active
      field :asset
    end
  end

# Model methods
  protected

  def update_person_and_job
    self.person = self.catalog.person
    self.job    = self.catalog.person.job
  end

  def catalog_id_enum
    Catalog.all.map {|c| ["#{c.name} - #{c.person.name} - #{c.person.job.name}", c.id]}
  end

end
