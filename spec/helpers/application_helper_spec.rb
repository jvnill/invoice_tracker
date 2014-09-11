require 'rails_helper'

describe ApplicationHelper do
  describe '#subnavlink' do
    let!(:output) { helper.subnavlink('icon', 'text', 'url') }

    it { expect(output).to eql('<a class="flat" href="url"><span class="icon-icon with-text"></span>text</a>') }
  end
end
