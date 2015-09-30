<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  load_and_authorize_resource param_method: :model_params
  before_action :set_<%= plural_table_name %>_breadcrumbs
  before_action :set_action_breadcrumbs

  def index
    @<%= plural_table_name %> = @<%= plural_table_name %>.order(created_at: :desc).page(params[:page])
  end

  def new
  end

  def create
    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: "#{<%= class_name %>.model_name.human} was successfully created."
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @<%= singular_table_name %>.update(model_params)
      redirect_to @<%= singular_table_name %>, notice: "#{<%= class_name %>.model_name.human} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_path, notice: "#{<%= class_name %>.model_name.human} was successfully destroyed."
  end

  private

    def model_params
      <%- if attributes_names.empty? -%>
      params.require(<%= ":#{singular_table_name}" %>)
      <%- else -%>
      params.require(<%= ":#{singular_table_name}" %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end

    def set_<%= plural_table_name %>_breadcrumbs
      add_crumb 'Home', root_path
      add_crumb <%= class_name %>.model_name.human.pluralize, <%= plural_table_name %>_path
      add_crumb @<%= singular_table_name %>.name_was, <%= singular_table_name %>_path(@<%= singular_table_name %>) if @<%= singular_table_name %>.try(:persisted?)
    end

    def set_action_breadcrumbs
      case params[:action]
      when 'new', 'create'
        add_crumb 'New'
      when 'edit', 'update'
        add_crumb 'Edit'
      end
    end

end
<% end -%>
