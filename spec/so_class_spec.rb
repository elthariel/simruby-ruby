##
## so_class_spec.rb
## Login : <lta@still>
## Started on  Mon Jun 17 19:16:57 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr

require 'spec_helper'
require 'so_class'

describe 'So Class:' do
  describe Point do
    describe 'creation' do
      it 'works' do
        point = Point.new(10, 20)

        point.is_a?(Point).should be_true
        point.x.should eq(10)
        point.y.should eq(20)
        point.pos.should eq([10, 20])
      end

      it 'works also without parameters' do
        point = Point.new

        point.is_a?(Point).should be_true
        point.x.should eq(0)
        point.y.should eq(0)
      end
    end

    describe 'operations:' do
      before(:each) do
        @p1 = Point.new(1, 2)
        @p2 = Point.new(3, 4)
      end

      it 'supports assignation' do
        @p1.x = @p1.y = 42

        @p1.x.should eq(42)
        @p1.y.should eq(42)
      end

      it 'supports relative move' do
        @p1.move!(5, 5)
        @p1.pos.should eq([6, 7])
      end
      it 'supports absolute move' do
        @p1.move_to!(5, 5)
        @p1.pos.should eq([5, 5])
      end
      it 'supports addition of 2 points' do
        p3 = @p1 + @p2
        p3.pos.should eq([4, 6])
      end
    end

    describe 'Magic' do
      it 'detects if it is at magic place' do
        Point.new.magic?.should be_false
        Point.new(42, 42).magic?.should be_true
      end
      it 'has a protected method that moves the point to magic position !' do
        point = Point.new

        expect { point.move_to_magic_position! }.to raise_error(NoMethodError)

        point.magic?.should be_false
        point.instance_eval { move_to_magic_position! }
        point.magic?.should be_true
      end
    end

    describe 'Random factory' do
      # Point's random Class Methods, takes 5 parameters:
      # - count, xmin, ymin, xmax, ymax
      # it returns count point with random position between [xmin, ymin] and [xmax, ymax]
      it 'creates bunch of random points' do
        points = Point.random(10, 5, 5, 100, 100)

        points.is_a?(Array).should be_true
        points.length.should eq(10)

        points.each do |point|
          point.is_a?(Point).should be_true
          expect(point.x).to be >= 5
          expect(point.y).to be >= 5
          expect(point.x).to be <= 100
          expect(point.y).to be <= 100
        end
      end

      it 'counts the number of random created objects' do
        count = Point.random_count
        Point.random(10, 5, 5, 100, 100)
        Point.random_count.should eq(10 + count)
      end
    end
  end

  describe ColouredPoint do
    it 'is a Point with a color' do
      white_point = ColouredPoint.new

      white_point.is_a?(Point).should be_true
      white_point.is_a?(ColouredPoint).should be_true

      white_point.x.should eq(0)
      white_point.y.should eq(0)
      white_point.color.should eq('FFFFFF')
    end

    it 'can change of colour' do
      white_point = ColouredPoint.new

      white_point.color = 'F1C420'
      white_point.color.should eq('F1C420')
    end

    it 'provides handy accessor for color components' do
      point = ColouredPoint.new(0, 0, '112233')

      point.red.should   eq('11')
      point.green.should eq('22')
      point.blue.should  eq('33')
    end

    it 'supports all Point\'s operations' do
      p1 = Point.new(1, 2)
      p2 = Point.new(3, 4)

      p3 = p1 + p2
      p3.move!(10, 10)
      p3.pos.should eq([14, 16])
    end
  end
end
