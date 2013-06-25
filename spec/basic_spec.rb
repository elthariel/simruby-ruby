##
## basic_spec.rb
## Login : <lta@still>
## Started on  Mon Jun 17 17:38:17 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr

require 'spec_helper'
require 'basic'

describe 'Basics:' do
  it 'Define constants and globals' do
    defined?(CONSTANT).should be_true
    defined?(CONSTANT2).should be_true

    defined?($my_string).should be_true
    $my_string.is_a?(String).should be_true

    defined?($my_symbol).should be_true
    $my_symbol.is_a?(Symbol).should be_true

    defined?($my_array).should be_true
    $my_array.is_a?(Array).should be_true

    defined?($my_float).should be_true
    $my_float.is_a?(Float).should be_true

    defined?($my_nil).should be_true
    $my_nil.should be_nil

    defined?($my_boolean).should be_true
    ($my_boolean == true or $my_boolean == false)
      .should be_true
  end

  it 'say Hello!' do
    hello().should eq("Hello, Ruby World!")
  end

  # Define a method called 'nothing' which takes 3 parameters with
  # default values (we don't care about the value of the defaults)
  # The method does nothing and return nil
  it 'supports default parameters value' do
    nothing().should be_nil
    nothing(1).should be_nil
    nothing(1, 2).should be_nil
    nothing(1, 2, 3).should be_nil
    expect { nothing(1, 2, 3, 4) }
      .to raise_error(ArgumentError)
  end

  it 'computes Fibonacci sequence' do
    fibonacci(1).should eq(1)
    fibonacci(2).should eq(1)
    fibonacci(3).should eq(fibonacci(1) + fibonacci(2))
    fibonacci(4).should eq(fibonacci(2) + fibonacci(3))
    fibonacci(12).should eq(144)
    fibonacci(18).should eq(2584)
    fibonacci(23).should eq(28657)
  end

  # Hint: 'def who_is_bigger(a, b, c)'
  it 'tells me the biggest' do
    who_is_bigger(84, 42, nil).should eq("nil detected")
    who_is_bigger(nil, 42, 21).should eq("nil detected")
    who_is_bigger(84, 42, 21).should eq("a is bigger")
    who_is_bigger(42, 84, 21).should eq("b is bigger")
    who_is_bigger(42, 21, 84).should eq("c is bigger")
  end

  # Reverse, upcase then removes all L, T and A.
  # Hint: google ruby string
  it 'does crazy stuff on strings' do
    expect(reverse_upcase_noLTA("Tries this at Home, Kids"))
      .to eq("SDIK ,EMOH  SIH SEIR")
    expect(reverse_upcase_noLTA("Ponies loves carrots"))
      .to eq("SORRC SEVO SEINOP")
    expect(reverse_upcase_noLTA("qwertyuiopasdfghjkl;zxcvbn"))
      .to eq("NBVCXZ;KJHGFDSPOIUYREWQ")
  end

  # array_42 takes an array as parameter and returns:
  # - true if there's a 42 in the array items
  # - false otherwise
  # Hint: Should be 2 lines (and can be one :)
  # Hint: google ruby array each
  it 'finds 42' do
    array_42([1, 2, 3, 4, 5, 6, 7 , 8, 9, 10]).should be_false
    array_42([1, 2, 3, 4, 5, 6, 7 , 8, 9, 42, 21, 10.5]).should be_true
  end

  # The magic_array function takes an array of number or an array of
  # array of number as parameter and return the same array :
  # - flattened (i.e. no more arrays in array)
  # - reversed
  # - with each number multiplicated by 2
  # - with each multiple of 3 removed
  # - with each number duplicate removed (any number should appear only once)
  # - sorted
  # Hint: You can do this in one line than less than 55 chars
  it 'does crazy stuff on Arrays' do
    expect(magic_array([1, 2, 3, 4, 5, 6]))
      .to eq([2, 4, 8, 10])
    expect(magic_array([1, [2, 3], 4, 5, 6, 23, 31, [1, 2, 3]]))
      .to eq([2, 4, 8, 10, 46, 62])
    expect(magic_array([[32, 54], [48, 12], [21, [1, 2, [3]]], 7, 8]))
      .to eq([2, 4, 14, 16, 64])
  end
end
