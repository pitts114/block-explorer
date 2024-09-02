require 'rails_helper'

RSpec.describe "blocks/new", type: :view do
  before(:each) do
    assign(:block, Block.new())
  end

  it "renders new block form" do
    render

    assert_select "form[action=?][method=?]", blocks_path, "post" do
    end
  end
end
