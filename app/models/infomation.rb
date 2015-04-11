class Infomation < ActiveRecord::Base

  validates :position, numericality: {
    only_integer:             true,
    greater_than_or_equal_to:    0,
    less_than:                 100
  }

  rails_admin do
    weight 99

    list do
      field :name
      field :position
      field :active
      field :content
    end

    edit do
      field :name
      field :position do
        default_value 0
      end
      field :active do
        default_value true
      end
      field :content, :wysihtml5 do
        config_options toolbar: { fa: true }, # use font-awesome instead of glyphicon
                       html: true, # enables html editor
                       parserRules: { tags: { p:1 } } # support for <p> in html mode
      end
    end
  end

end
