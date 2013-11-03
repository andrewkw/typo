Feature: Merge articles
  As an admin
  In order to combine similar articles
  I want to merge articles

  Background:
    Given the blog is set up

    And the following users exist:
      | login | password | email            | state  | profile_id |
      | user1 | userpass | user1@domain.com | active | 2          |
      | user2 | userpass | user2@domain.com | active | 3          |

    And the following articles exist:
      | id | title    | author  | body  | allow_comments | published | user_id |
      | 3  | article1 | user1   | body1 | 1              | 1         | 2       |
      | 4  | article2 | user2   | body2 | 1              | 1         | 3       |

    And the following comments exist:
      | id | article_id | author   | body     |
      | 1  | 3          | user1    | comment1 |
      | 2  | 4          | user2    | comment2 |
  
  Scenario: A non-admin cannot merge two articles
    Given I am logged in as "user1" with the password "userpass"
    And I am on the edit page of the Article with id "3"
    Then I should not see "Merge"

  Scenario: An admin can see the option to merge articles
    Given I am logged in as "admin" with the password "aaaaaaaa"
    And I am on the edit page of the Article with id "3"
    Then I should see "Merge"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given the article with id "3" has been merged with article with id "4"
    Then the article with id "3" should have body "body1body2"

  Scenario: After articles have been merged, the resulting article should have the author of either of the previous articles
    Given the article with id "3" has been merged with article with id "4"
    Then the article with id "3" should have author "user1" or "user2"
    
  Scenario: After articles have been merged, the resulting article should contain the comments from both of the previous articles
    Given the article with id "3" has been merged with article with id "4"
    And I am on the home page
    Then I should see "article1"
    And I should not see "article2"
    When I follow "article1"
    Then I should see "comment1"
    And I should see "comment2"

  Scenario: After articles have been merged, the resulting article should have the title of either of the previous articles
    Given the article with id "3" has been merged with article with id "4"
    Then the article with id "3" should have title "article1" or "article2"
