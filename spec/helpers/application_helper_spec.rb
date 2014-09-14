require 'rails_helper'

describe ApplicationHelper do
  describe '#navlink' do
    it { expect(helper.navlink('text', 'url', true)).to eql('<li class="active"><a href="url">text</a></li>') }
    it { expect(helper.navlink('text', 'url', false)).to eql('<li><a href="url">text</a></li>') }
    it { expect(helper.navlink('text', 'url', false, class: 'foo')).to eql('<li><a class="foo" href="url">text</a></li>') }
  end

  describe '#subnavlink' do
    let!(:output) { helper.subnavlink('icon', 'text', 'url') }

    it { expect(output).to eql('<a class="flat" href="url"><span class="icon-icon with-text"></span>text</a>') }
  end
end
