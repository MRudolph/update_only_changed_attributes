require 'test_helper'

class UpdateOnlyChangedAttributesTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, UpdateOnlyChangedAttributes
  end

  test "old:create should fail with mass assigning protected attributes" do
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) do
      Thing.create(a:"a",b:"b",c:"c")
    end 
  end
  
  test "old:updating unprotected attributes should work" do
    thing = Thing.create({a:"a",b:"b",c:"c"},without_protection: true)
    assert_nothing_raised(ActiveModel::MassAssignmentSecurity::Error) do
      thing.update_attributes({a:"newA"})
    end
    assert_equal thing.a,"newA"
  end
  test "old:updating protected attributes should be blocked" do
    thing = Thing.create({a:"a",b:"b",c:"c"},without_protection: true)
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) do
      thing.update_attributes({b:"newB"})
    end
    assert_equal thing.b,"b"
  end
  test "new:changing protected attributes should still be blocked" do
    thing = Thing.create({a:"a",b:"b",c:"c"},without_protection: true)
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) do
      thing.update_only_changed_attributes({b:"newB"})
    end
    assert_equal thing.b,"b"
  end
  test "new:updating protected attributes whith same value should do nothing" do
    thing = Thing.create({a:"a",b:"b",c:"c"},without_protection: true)
    assert_nothing_raised(ActiveModel::MassAssignmentSecurity::Error) do
      thing.update_only_changed_attributes({b:"b"})
    end
    assert_equal thing.b,"b"
  end
  test "new:updating unprotected attributes should still work" do
    thing = Thing.create({a:"a",b:"b",c:"c"},without_protection: true)
    assert_nothing_raised(ActiveModel::MassAssignmentSecurity::Error) do
      thing.update_only_changed_attributes({a:"newA"})
    end
    assert_equal thing.a,"newA"
  end
  test "new:mixing unprotected and protected attributes should work if the protected are not modified" do
    thing = Thing.create({a:"a",b:"b",c:"c"},without_protection: true)
    assert_nothing_raised(ActiveModel::MassAssignmentSecurity::Error) do
      thing.update_only_changed_attributes({a:"newA",b:"b"})
    end
    assert_equal thing.a,"newA"
    assert_equal thing.b,"b"
    assert_equal thing.c,"c"
  end   
  test "new:mixing unprotected and protected attributes should fail completely if protected is changed" do
    thing = Thing.create({a:"a",b:"b",c:"c"},without_protection: true)
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) do
      thing.update_attributes({a:"newA",b:"b",c:"newC"})
    end
    assert_equal thing.a,"a"
    assert_equal thing.b,"b"
    assert_equal thing.c,"c"
  end
  test "new: attribute_change_delta returns only the changed data" do
    thing = Thing.create({a:"a",b:"b",c:"c"},without_protection: true)
    change =thing.attribute_change_delta({a: "newA",b:"b"})
    assert_equal change, {a:"newA"}
  end  
  
end
