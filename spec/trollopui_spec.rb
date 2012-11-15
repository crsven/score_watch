require 'spec_helper'

describe 'Trollop UI' do
  before do
    ARGV.push '555555'
  end

  it 'sets the Growl option correctly' do
    ARGV.push '--growl'
    opts = TrollopUI.parse
    expect(opts[:growl]) == true
  end

  it 'sets the CLI option to the default' do
    opts = TrollopUI.parse
    expect(opts[:cli]) == true
  end

  it 'sets the CLI option to false' do
    ARGV.push '--cli', 'false'
    opts = TrollopUI.parse
    expect(opts[:cli]) == false
  end
end
