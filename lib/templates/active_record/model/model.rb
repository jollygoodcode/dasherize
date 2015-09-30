<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  # Extends

  # Includes

  # Associations
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %>
<% end -%>

  # accepts_nested_attributes

  # Delegates

  # Validations

  # Scopes

  # Callbacks

  # Custom
  # friendly_id ..
  # has_attached_file
  # enumerize ..

  # Methods (class methods before instance methods)
end
<% end -%>
