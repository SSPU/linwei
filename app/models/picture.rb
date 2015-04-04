class Picture < ActiveRecord::Base

  before_save :update_person_and_job

  after_save :update_seq

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
    w_small:  "150" ,
    w_star:   "430" ,
    w_medium: "300" ,
    h_medium: "x300",
    h_large:  "x900"
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
      field :asset
      field :active
      field :position
      field :video
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
      field :active do
        default_value true
      end
      field :video
      field :asset
    end
  end

  # Model functions
  def prev_pic
    if self.seq == 0
      prev_seq = self.max_seq
    else
      prev_seq = self.seq - 1
    end
    Picture.where(catalog_id: self.catalog_id, seq: prev_seq).take
  end

  def next_pic
    if self.seq == max_seq
      next_seq = 0
    else
      next_seq = self.seq + 1
    end
    Picture.where(catalog_id: self.catalog_id, seq: next_seq).take
  end

  # Callback functions and Rails Admin helpers
  protected

  def update_person_and_job
    self.person = self.catalog.person
    self.job    = self.catalog.person.job
  end

  def catalog_id_enum
    Catalog.all.map {|c| ["#{c.name} - #{c.person.name} - #{c.person.job.name}", c.id]}
  end

  def update_seq
    self.update_columns(seq: -1, max_seq: -1) if !self.active

    pics = Picture.where(catalog_id: self.catalog_id,
                          active: true).order(position: :asc, created_at: :asc)
    (0...pics.size).select do |i|
      pics[i].update_columns(seq: i, max_seq: pics.size - 1)
    end
  end

end
