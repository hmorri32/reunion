require 'minitest'
require 'minitest/test'
require 'minitest/autorun'
require './lib/reunion'

class ReunionTest < Minitest::Test
  def test_exists
    r = Reunion.new('noobnoob')
    
    assert r 
    assert_instance_of Reunion, r
  end
  
  def test_reunion_initialized_with_name
    r = Reunion.new('noobnoob')

    assert_equal 'noobnoob', r.name
  end
  
  def test_can_add_activity 
    r = Reunion.new('noobnoob')
    a = Activity.new('cool thing')
    r.add_activity(a)

    assert_equal 1, r.activities.length
    assert_instance_of Activity, r.activities.first
  end

  def test_can_find_total_cost
    r = Reunion.new('montañas')
    a = Activity.new('ultra hiking')
    r.add_activity(a)
    peep1 = a.add_participant('bob', 20)
    peep2 = a.add_participant('benedect', 50)

    assert_equal 70, r.total_cost
  end

  def test_can_breakdown_tab_one_activity
    r = Reunion.new('montañas')
    a = Activity.new('ultra hiking')
    r.add_activity(a)
    peep1 = a.add_participant('bob', 20)
    peep2 = a.add_participant('benedect', 50)

    assert_equal ({"bob"=>15, "benedect"=>-15}), r.breakdown
  end

  def test_can_breakout_tab_multiple_activities 
    r = Reunion.new('montañas')
    a = Activity.new('ultra hiking')
    r.add_activity(a)
    a.add_participant('bob', 20)
    a.add_participant('benedect', 50)

    a2 = Activity.new('ultrahotTub')
    r.add_activity(a2)

    a2.add_participant('bob', 30)
    a2.add_participant('benedect', 40) 
    
    assert_equal 140, r.total_cost
    assert_equal 2, r.activities.length
    assert_equal ({"bob"=>20, "benedect"=>-20}), r.breakdown
  end

  def test_can_print_tab 
    r = Reunion.new('montañas')
    a = Activity.new('ultra hiking')
    r.add_activity(a)
    a.add_participant('bob', 20)
    a.add_participant('benedect', 50)

    a2 = Activity.new('ultrahotTub')
    r.add_activity(a2)

    a2.add_participant('bob', 30)
    a2.add_participant('benedect', 40) 
    expected = "bob owes 20 benedect owes -20 "
    
    assert_equal expected, r.print_tab_summary
  end
end