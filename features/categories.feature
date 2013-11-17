Feature: Create new features and edit existing features
  As an admin
  In order to group articles with similar content
  I want to create categories and assign them to articles

Background:
  Given the blog is set up
  And I am logged into the admin panel
  When I follow "Categories"

Scenario: Link should direct to proper path
  Then I should see "Categories"
  And I should see "Name"
  And I should see "Keywords"

Scenario: Create new categories
  When I fill in "Name" with "category"
  And I press "Save"
  Then I should see "category"

Scenario: Edit existing features
  When I follow "General"
  And I fill in "Description" with "description"
  And I press "Save"
  Then I should see "description"
