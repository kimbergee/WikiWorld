##Wiki World

This is a production quality SaaS app that allows users to create and collaborate on their own wikis.

##Features
+ 2 membership types: Standard and Premium. Standard users can create and edit public wikis. Premium users can create private wikis and add collaborators. Nonmembers can browse public wikis as a guest.
+ Users can upgrade & downgrade easily and pay premium membership fees using Stripe.
+ Redcarpet is used to allow users to create/edit wikis using Markdown.
+ Devise is used for user authentication.
+ Pundit is used for authorization between private and public wikis.

##Getting Started
Clone or download this repository and then run:
```
$ bundle install
```


Run the project on your local server:
```
$ rails s
```


Navigate to `localhost:3000` in your browser.
