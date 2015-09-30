require 'rails_helper'

<% module_namespacing do -%>
describe <%= controller_class_name %>Controller do
  let(:user) { create(:user) }

  before { sign_in user }

<% unless options[:singleton] -%>
  describe '#index' do
    def do_request
      get :index
    end

    before { do_request }

    xit { expect(response).to be_success }
  end

<% end -%>
  describe '#new' do
    def do_request
      get :new
    end

    before { do_request }

    xit { expect(assigns[:<%= ns_file_name %>]).to be_instance_of(<%= class_name %>) }
    xit { expect(response).to be_success }
  end

  describe '#create' do
    def do_request
      post :create, <%= ns_file_name %>: params
    end

    context 'success' do
      let(:params) { Hash(name: 'foo') }

      xit 'creates new <%= ns_file_name %>' do
        expect { do_request }.to change(<%= class_name %>, :count).by(1)
      end

      xit 'redirects' do
        do_request
        expect(response).to redirect_to <%= ns_file_name %>_path(assigns(:<%= ns_file_name %>))
      end
    end

    context 'failure' do
      let(:params) { Hash(name: nil) }

      xit 'does not create <%= ns_file_name %>' do
        expect { do_request }.not_to change(<%= class_name %>, :count)
      end

      xit 'renders new' do
        do_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#show' do
    let(:<%= ns_file_name %>) { create(:<%= ns_file_name %>, user: user) }

    def do_request
      get :show, id: <%= ns_file_name %>.id
    end

    before { do_request }

    xit { expect(assigns(:<%= ns_file_name %>)).to eq <%= ns_file_name %> }
    xit { expect(response).to be_success }
  end

  describe '#edit' do
    let(:<%= ns_file_name %>) { create(:<%= ns_file_name %>, user: user) }

    def do_request
      get :edit, id: <%= ns_file_name %>.id
    end

    before { do_request }

    xit { expect(assigns(:<%= ns_file_name %>)).to eq <%= ns_file_name %> }
    xit { expect(response).to be_success }
  end

  describe '#update' do
    let(:<%= ns_file_name %>) { create(:<%= ns_file_name %>, user: user) }

    def do_request
      patch :update, id: <%= ns_file_name %>.id, <%= ns_file_name %>: params
    end

    before { do_request }

    context 'success' do
      let(:params) { Hash(id: <%= ns_file_name %>.id, name: <%= ns_file_name %>.name + '-modified') }

      before { do_request }

      xit { expect(assigns(:<%= ns_file_name %>).name).to match '-modified' }
      xit { expect(response).to redirect_to <%= ns_file_name %>_path(assigns(:<%= ns_file_name %>)) }
    end

    context 'failure' do
      let(:params) { Hash(name: '') }

      xit { expect(response).to render_template :edit }
    end
  end

  describe '#destroy' do
    let!(:<%= ns_file_name %>) { create(:<%= ns_file_name %>, user: user) }

    def do_request
      delete :destroy, id: <%= ns_file_name %>.id
    end

    xit 'deletes a <%= ns_file_name %>' do
      expect { do_request }.to change(<%= class_name %>, :count).by(-1)
    end

    xit 'redirects' do
      do_request
      expect(response).to redirect_to <%= index_helper %>_path
    end
  end
end
<% end -%>
