require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'

class ActivityTest < Minitest::Test
  def test_exists 
    activity = Activity.new('cool')
    assert activity 
    assert_instance_of Activity, activity
  end

  def test_activity_has_a_name 
    activity = Activity.new('cool')
    
    assert_equal 'cool', activity.name    
  end

  def test_activity_has_participants 
    activity = Activity.new('cool')

    assert_equal ({}), activity.participants
  end
  
  def test_activity_has_total_cost 
    activity = Activity.new('cool')
  
    assert_equal 0, activity.total_cost
  end

  def test_can_add_participant_and_calculate_total
    activity = Activity.new('cool')
    activity.add_participant('jim', 20)
    
    assert_equal ({"jim"=>20}), activity.participants
    assert_equal 20, activity.total_cost
  end

  def test_participants_can_split_total
    activity = Activity.new('cool')
    activity.add_participant('jim', 20)
    activity.add_participant('rico', 40)

    assert_equal 30, activity.split
  end

  def test_can_calculate_amount_owed 
    activity = Activity.new('cool')
    activity.add_participant('jim', 20)
    activity.add_participant('rico', 40)

    assert_equal ({"jim"=>10, "rico"=>-10}), activity.calculate_amount_owed
  end
end
