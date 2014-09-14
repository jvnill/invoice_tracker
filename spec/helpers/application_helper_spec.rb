require 'rails_helper'

describe ApplicationHelper do
  describe '#navlink' do
    it { expect(helper.navlink('text', '')).to eql('<li class="active"><a href="">text</a></li>') }
    it { expect(helper.navlink('text', 'url')).to eql('<li><a href="url">text</a></li>') }
    it { expect(helper.navlink('text', 'url', class: 'foo')).to eql('<li><a class="foo" href="url">text</a></li>') }
  end
end
