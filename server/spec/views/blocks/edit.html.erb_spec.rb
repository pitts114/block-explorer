require 'rails_helper'

RSpec.describe "blocks/edit", type: :view do
  let(:block) {
    Block.create!()
  }

  before(:each) do
    assign(:block, block)
  end

  it "renders the edit block form" do
    render

    assert_select "form[action=?][method=?]", block_path(block), "post" do
    end
  end
end
