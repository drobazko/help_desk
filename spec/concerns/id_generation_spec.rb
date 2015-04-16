require 'spec_helper'

describe IdGeneration do
  class Dummy
    include IdGeneration::ClassMethods
  end

  subject { Dummy.new }

  def get_uniq_id
    subject.get_uniq_id
  end
  
  it { should get_uniq_id.match(/[A-Z]{2}-[0-9]{2}-[A-Z]{2}-[0-9]{2}-[A-Z]{2}/) }
end