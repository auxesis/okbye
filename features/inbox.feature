Feature: Inbox
  To make notmuch useful
  A user
  Must be able to view the inbox

  Scenario: List threads
    When I go to "/"
    Then I should see a list of messages
  
  Scenario: Show thread
    When I go to "/"
    Then I should see a list of messages
    When I follow the first thread
    Then I should see an email

  Scenario: Navigate between threads
    When I go to "/"
    Then I should see a list of messages
    When I follow the first thread
    Then I should see an email
    When I follow "back"
    Then I should see a list of messages

  Scenario: Search by tag
    When I go to "/"
    And I fill in "search" with "tag:unread"
    Then I should see a list of messages

