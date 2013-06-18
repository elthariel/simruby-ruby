##
## metaprog_spec.rb
## Login : <lta@still>
## Started on  Tue Jun 18 11:32:26 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr

require 'spec_helper'
require 'so_class'
require 'advanced'

#
# This last bag of spec contains a few advanced ruby stuff as well as
# some other mid-level stuff which weren't fitting in the previous
# series.
#
describe Advanced do
  it 'is a module' do
    (Advanced.class == Module).should be_true
    # is almost the same as
    (Advanced.is_a?(Module)).should be_true
  end
  describe 'with methods' do
    # Advanced.class_as_string(klass) return the name of the class of
    # the object given in parameter
    specify '#class_as_string' do
      Advanced.class_as_string(Array).should eq('Array')
      Advanced.class_as_string(Hash).should eq('Hash')
      Advanced.class_as_string(String).should eq('String')
    end

    # Hint: Google: 'ruby const_get', 'ruby Kernel'
    specify '#string_as_class' do
      Advanced.string_as_class('String').should eq(String)
      Advanced.string_as_class('String').new.is_a?(String).should be_true

      Advanced.string_as_class('Array').should eq(Array)
      array = Advanced.string_as_class('Array').new
      array << 1 << 2 << 3
      array.is_a?(Array).should be_true
      array.should eq([1, 2, 3])

      Advanced.string_as_class('Point').should eq(Point)
      point = Advanced.string_as_class('Point').new
      point.is_a?(Point).should be_true
      point.pos.should eq([0, 0])
    end

    specify '#respond_to_each?' do
      Advanced.respond_to_each?(Hash.new).should be_true
      Advanced.respond_to_each?(Array.new).should be_true
      Advanced.respond_to_each?({}).should be_true # same as first one
      Advanced.respond_to_each?([]).should be_true # same as second one

      Advanced.respond_to_each?(0..10).should be_true
    end

    # Hint: google 'ruby method_missing', 'Symbol#to_s / String#to_sym'
    specify '#respond_to_something?' do
      Advanced.respond_to_uniq?(Array.new).should be_true
      Advanced.respond_to_unexistent?(Array.new).should be_false
      Advanced.respond_to_keys?(Hash.new).should be_true
      Advanced.respond_to_unexistent?(Hash.new).should be_false
      expect { Advanced.unexistent?(Hash.new) }
        .to raise_error
      expect { Advanced.respond_to_keys(Hash.new) }
        .to raise_error
    end

    # Hint: This is a one-liner
    specify '#calculette' do
      Advanced.calculette('1 + 1').should eq(2)
      Advanced.calculette('(5 * 5 - 2) / 0.5').should eq(46.0)
      Advanced.calculette('2 ** 2').should eq(4)
    end
  end
end
