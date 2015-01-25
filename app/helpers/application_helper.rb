module ApplicationHelper

  def to_html(content)
    raw(content.gsub(/\n/, "<br />"))
  end

  def image_url(source)
    "#{request.protocol}#{request.host_with_port}#{image_path(source)}"
  end

  def state_collection(short=false)
    if short
      ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY']
    else
      [['Alabama', 'AL'], ['Alaska', 'AK'], ['Arizona', 'AZ'], ['Arkansas', 'AR'], ['California', 'CA'], ['Colorado', 'CO'], ['Connecticut', 'CT'], ['Delaware', 'DE'], ['District of Columbia', 'DC'], ['Florida', 'FL'], ['Georgia', 'GA'], ['Hawaii', 'HI'], ['Idaho', 'ID'], ['Illinois', 'IL'], ['Indiana', 'IN'], ['Iowa', 'IA'], ['Kansas', 'KS'], ['Kentucky', 'KY'], ['Louisiana', 'LA'], ['Maine', 'ME'], ['Maryland', 'MD'], ['Massachusetts', 'MA'], ['Michigan', 'MI'], ['Minnesota', 'MN'], ['Mississippi', 'MS'], ['Missouri', 'MO'], ['Montana', 'MT'], ['Nebraska', 'NE'], ['Nevada', 'NV'], ['New Hampshire', 'NH'], ['New Jersey', 'NJ'], ['New Mexico', 'NM'], ['New York', 'NY'], ['North Carolina', 'NC'], ['North Dakota', 'ND'], ['Ohio', 'OH'], ['Oklahoma', 'OK'], ['Oregon', 'OR'], ['Pennsylvania', 'PA'], ['Rhode Island', 'RI'], ['South Carolina', 'SC'], ['South Dakota', 'SD'], ['Tennessee', 'TN'], ['Texas', 'TX'], ['Utah', 'UT'], ['Vermont', 'VT'], ['Virginia', 'VA'], ['Washington', 'WA'], ['West Virginia', 'WV'], ['Wisconsin', 'WI'], ['Wyoming', 'WY']]
    end
  end

  def linker(text, path, options = {})
    active_class = options[:active_class] ? options[:active_class] : 'active'
    classes = options[:class] ? options[:class] : ''
    icon = options[:icon]

    key = options[:key]
    active = key ? controller.controller_name == key : current_page?(path)

    content_tag :li, class: (active ? active_class : '') do
      link_to(path, class: classes) do |a|
        if icon
          raw("<span class='glyphicon glyphicon-#{icon}'></span> #{text}")
        else
          raw("#{text}")
        end
      end
    end
  end

  def date_options
    { as: :date, order: [:month, :day, :year], start_year: Time.now.year, label: false }
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder, i: 0)
    end
    link_to(name, "javascript:{};", class: "btn btn-default add_fields", data: { id: id, fields: fields.gsub("\n", "") })
  end

end
