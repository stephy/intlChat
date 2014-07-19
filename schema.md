LoginViewController
SignUpViewController

MainViewController
  - Container for Friends, Chats and Profile View Controllers

FriendsViewController
  - List of friends

ChatsViewController
  - List of chats opened

ChatViewController
 - Chat view

MessageDetailViewController
 - Message Details
 - When user clicks on a message on ChatViewController, this view appears and user can view the original message and the translation

ProfileViewController
 - User settings page


Schema
======

User (Friend)
 - userid
 - fullname
 - email
 - language
 - password

Friends
 - userId
 - friendId

Chats
 - chatId
 - userId

Messages
 - chatId
 - messageSequence
 - originalMessage
 - translatedMessage



Relationships 
==============
 - User 1:MANY Friends (Users)
 - Users 1:MANY Chats
 - Chats 1:MANY Messages



