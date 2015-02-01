require 'rails_helper'

describe ApplicationHelper do
  describe '#icon_link' do
    it { expect(helper.icon_link('icon', 'text', 'url')).to eql('<a href="url"><span class="icon icon-icon"></span>text</a>') }
  end

  describe '#navlink' do
    it { expect(helper.navlink('text', '')).to eql('<li class="active"><a href="">text</a></li>') }
    it { expect(helper.navlink('text', 'url')).to eql('<li><a href="url">text</a></li>') }
    it { expect(helper.navlink('text', 'url', class: 'foo')).to eql('<li><a class="foo" href="url">text</a></li>') }
  end

  describe '#project_select' do
    let!(:user) { create(:user) }

    before { expect(helper).to receive(:grouped_project_options).and_return({ 1 => [2] }) }

    it { expect(helper.project_select(user.projects)).to eql("<select name=\"invoice[project_id]\" id=\"invoice_project_id\"><option value=\"\"></option>\n<optgroup label=\"1\"><option value=\"2\">2</option></optgroup></select>") }
  end

  describe '#grouped_project_options' do
    let!(:user)     { create(:user) }

    let!(:client1)  { create(:client, name: 'A', user: user) }
    let!(:project1) { create(:project, name: 'A', client: client1) }
    let!(:project2) { create(:project, name: 'B', client: client1) }

    let!(:client2)  { create(:client, name: 'B', user: user) }
    let!(:project3) { create(:project, name: 'D', client: client2) }
    let!(:project4) { create(:project, name: 'C', client: client2) }

    it { expect(helper.grouped_project_options(user.projects)).to eql({ client1.name => [[project1.name, project1.id], [project2.name, project2.id]], client2.name => [[project4.name, project4.id], [project3.name, project3.id]] }) }
  end

  describe '#details_block' do
    let!(:details) { { foo: 'bar', bar: 'foo', empty: '', nil: nil } }

    before { allow(helper).to receive(:detail_block).twice.and_return(nil) }

    it { expect(helper.details_block(details)).to eql('<ul class="small-block-grid-2 medium-block-grid-4 large-block-grid-6"><li></li><li></li></ul>') }
  end

  describe '#detail_block' do
    it { expect(helper.detail_block('Invoice Number', 'value')).to eql('<ul class="pricing-table invoice-number"><li class="title">Invoice Number</li><li class="bullet-item">value</li></ul>') }
  end
end
