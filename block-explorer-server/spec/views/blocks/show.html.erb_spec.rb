require 'rails_helper'

RSpec.describe "blocks/show", type: :view do
  before(:each) do
    assign(:block, Block.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
