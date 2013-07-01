##
## modules_spec.rb
## Login : <lta@still>
## Started on  Tue Jun 18 01:03:43 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr

require 'spec_helper'
require 'modules'

describe Geometry do
  it 'has a VERSION constant' do
    defined?(Geometry::VERSION).should be_true
    Geometry::VERSION.should eq('0.0.1')
  end

  # Geometry.distance(p1, p2) return the distance between p1 and p2
  it 'has a distance module method' do
    p1 = Point.new
    p2 = Point.new(10, 0)
    p3 = Point.new(10, 10)

    Geometry.distance(p1, p2).should eq(10)
    Geometry.distance(p1, p3).should eq(Math.sqrt(200))
  end

  describe Geometry::Shape do
    before(:each) do
      @p1 = Point.new
      @p2 = Point.new(5, 5)
      @p3 = Point.new(0, 10)
    end

    it 'can be created' do
      shape = Geometry::Shape.new()

      shape.is_a?(Geometry::Shape).should be_true
      shape.points.empty?.should be_true
    end

    it 'can be created with a list of points' do
      shape = Geometry::Shape.new [@p1, @p2, @p3]

      shape.is_a?(Geometry::Shape).should be_true
      shape.points.is_a?(Array).should be_true
      shape.points.length.should eq(3)
      shape.points.first.should eq(@p1)
      shape.points.last.should eq(@p3)
    end

    it 'can grow and shrink' do
      shape = Geometry::Shape.new
      shape.points.length.should eq(0)

      shape.add_point(@p1)
      shape.add_point(@p2)
      shape.add_point(@p3)
      shape.points.should eq([@p1, @p2, @p3])

      shape.remove_point
      shape.points.should eq([@p1, @p2])
    end
  end

  describe 'Detectors' do
    example 'There are 2 detectors' do
      Geometry::LineDetector.is_a?(Module).should be_true
      Geometry::TriangleDetector.is_a?(Module).should be_true
      #Geometry::RectangleDetector.is_a?(Module).should be_true
    end

    it 'The detectors are _included_ in Shape' do
      Geometry::Shape.include?(Geometry::LineDetector).should be_true
      Geometry::Shape.include?(Geometry::TriangleDetector).should be_true
      #Geometry::Shape.include?(Geometry::RectangleDetector).should be_true
    end

    describe Geometry::LineDetector do
      it 'has a line? method' do
        Geometry::LineDetector.instance_methods.include?(:line?).should be_true
      end

      it 'detects if the shape is a line' do
        p1 = Point.new
        p2 = Point.new(1, 1)
        shape = Geometry::Shape.new([p1, p2])
        shape.line?.should be_true
      end

      it 'detects if the points create a real line' do
        p1 = Point.new(0, 0)
        p2 = Point.new(0, 0)
        shape = Geometry::Shape.new([p1, p2])
        shape.line?.should be_false
      end
    end

    describe Geometry::TriangleDetector do
      it 'has a triangle? method' do
        Geometry::TriangleDetector.instance_methods.include?(:triangle?).should be_true
      end

      it 'detects if the shape is a triangle' do
        p1 = Point.new
        p2 = Point.new(0.5, 1)
        p3 = Point.new(1, 0)
        shape = Geometry::Shape.new([p1, p2, p3])
        shape.triangle?.should be_true
      end
    end
  end
end
