# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - Built with sinatra
- [x] Use ActiveRecord for storing information in a database - Built with ActiveRecord
- [x] Include more than one model class (e.g. User, Post, Category) - Have three classes, User, Motorcycle, and Brand
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - User has many motorcycles, Brand has many Motorcycles
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - Motorcycle belongs to a User and a Brand
- [x] Include user accounts with unique login attribute (username or email) - Has unique User accounts with passwords
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - All objects have CRUD routes
- [x] Ensure that users can't modify content created by other users - Only logged in user can edit their own content
- [x] Include user input validations - Users must provide certain information to create objects
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - Flash messages for validation failures
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - Readme added

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message