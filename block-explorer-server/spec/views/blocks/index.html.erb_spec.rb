require 'rails_helper'

RSpec.describe "blocks/index", type: :view do
  before(:each) do
    assign(:blocks, [
      Block.create!(),
      Block.create!()
    ])
  end

  it "renders a list of blocks" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
