# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :vertical_form, tag: "div", class: "input-field", error_class: "has-error" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :input, class: "validate", error_class: "invalid"
    b.use :label

    b.use :error, wrap_with: { tag: "p", class: "error-block" }
    b.use :hint,  wrap_with: { tag: "p", class: "help-block" }
  end

  # Wrappers for forms and inputs using the Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :vertical_form

  # Old Bootstrap styling
  config.wrappers :vertical_file_input, tag: "div", class: "form-group", error_class: "has-error" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label, class: "control-label"

    b.use :input
    b.use :error, wrap_with: { tag: "span", class: "help-block" }
    b.use :hint,  wrap_with: { tag: "p", class: "help-block" }
  end

  config.wrappers :vertical_boolean, tag: "div", class: "form-group", error_class: "has-error" do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: "div", class: "checkbox" do |ba|
      ba.use :label_input
    end

    b.use :error, wrap_with: { tag: "span", class: "help-block" }
    b.use :hint,  wrap_with: { tag: "p", class: "help-block" }
  end

  config.wrappers :vertical_radio_and_checkboxes, tag: "div", class: "form-group", error_class: "has-error" do |b|
    b.use :html5
    b.optional :readonly
    b.use :label_input
    b.use :error, wrap_with: { tag: "span", class: "help-block" }
    b.use :hint,  wrap_with: { tag: "p", class: "help-block" }
  end

  config.wrappers :horizontal_form, tag: "div", class: "form-group", error_class: "has-error" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: "form-left control-label"

    b.wrapper tag: "div", class: "form-right" do |ba|
      ba.use :input, class: "form-control"
      ba.use :error, wrap_with: { tag: "span", class: "help-block" }
      ba.use :hint,  wrap_with: { tag: "p", class: "help-block" }
    end
  end

  config.wrappers :horizontal_file_input, tag: "div", class: "form-group", error_class: "has-error" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label, class: "form-left control-label"

    b.wrapper tag: "div", class: "form-right" do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: "span", class: "help-block" }
      ba.use :hint,  wrap_with: { tag: "p", class: "help-block" }
    end
  end

  config.wrappers :horizontal_boolean, tag: "div", class: "form-group", error_class: "has-error" do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: "div", class: "form-left-offset form-right" do |wr|
      wr.wrapper tag: "div", class: "checkbox" do |ba|
        ba.use :label_input, class: "form-right"
      end

      wr.use :error, wrap_with: { tag: "span", class: "help-block" }
      wr.use :hint,  wrap_with: { tag: "p", class: "help-block" }
    end
  end

  config.wrappers :horizontal_radio_and_checkboxes, tag: "div", class: "form-group", error_class: "has-error" do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: "form-left control-label"

    b.wrapper tag: "div", class: "form-right" do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: "span", class: "help-block" }
      ba.use :hint,  wrap_with: { tag: "p", class: "help-block" }
    end
  end

  config.wrappers :inline_form, tag: "div", class: "form-group", error_class: "has-error" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: "sr-only"

    b.use :input, class: "form-control"
    b.use :error, wrap_with: { tag: "span", class: "help-block" }
    b.use :hint,  wrap_with: { tag: "p", class: "help-block" }
  end
end
