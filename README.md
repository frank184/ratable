# Ratable

A simple gem that provides a lightweight framework for building a rating systems and includes the JQuery Raty library from https://github.com/wbotelhos/raty.

### Todo

2. Write the automated tests using Rspec
3. Gather feedback for another iteration

### Getting Started

1. Add the gem to your Gemfile `gem 'ratable'`.
2. Run the installer `rails g ratable:install`.
3. Run the views generator `rails g ratable:views` *(recommended)*.
4. Add `acts_as_ratee` to the model to be rated.
5. Add `acts_as_rater` to the model doing the rating *(optional)*.
6. Add `//= require ratable` to your application.js file.
6. Add `*= require ratable` to your application.css file.

As for creating the process and flow, this is left up to the developer.

A good starting point is to utilize the default view and add the following to your JavaScript:

```javascript
$(function() {
  $('.rating').each(function() {
    $this = $(this);
    $this.raty({
      readOnly: true,
      score: $this.data('rating'),
      scoreName: 'star',
      space: true
    });
  });
});
```

The default view hints to use HMLT5 data attributes to store the rating value:

```html
<div class="rating" data-rating="<%= rating.value %>"></div>
```

And can then be used as follows:

```ruby
<%= render @book.ratings %>
```

Of course this will vary from one use case to another.

### Rating Model

The `Ratable::Rating` model will be added to your `schema.rb` after running the migration added by `rails g ratable:install`. This model has a polymorphic `ratee` and `rater`.

The `Ratable::Rating` attributes are:

* `ratee`: poly reference (ratee_id, ratee_type) *(required)*
* `rater`: poly reference (rater_id, rater_type) *(optional)*
* `value`: integer *(required)*
* `comment`: text *(optional)*

The only required attributes for a `Ratable::Rating` are `ratee` and `value`.

### Methods

`acts_as_ratee`: Makes a model ratable. Accepts the parameter `has_one`, which is a boolean. Defaults to a `has_many` relationship, but can be changed to `has_one` by passing `acts_as_ratee(has_one: true)`.

`acts_as_rater`: Makes a model the rater of a ratable model. Accepts the parameter `has_one`, which is a boolean. Defaults to a `has_many` relationship, but can be changed to `has_one` by passing: `acts_as_rater(has_one: true)`.

`acts_as_ratable`: Makes a model a ratee and rater of ratable models. Accepts the parameters `has_one_ratee` and `has_one_rater`, which are booleans. Defaults to a `has_many` relationship, but can be changed to `has_one` by passing: has_one_ratee` or `has_one_rater`.

`ratee.ratings`: Returns a ratee's associated ratings.

`rater.ratings`: Returns a rater's associated ratings.

`ratable.ratee_ratings`: Returns the ratee associated ratings.

`ratable.rater_ratings`: Returns the rater associated ratings.

`ratee.rate(attributes)`: Creates a Rating for the ratee in question and for the rater passed in the parameters.

`rater.rate(attributes)`: Creates a Rating for the rater in question and for the ratee passed in the parameters.

`ratable.ratee_rate(attributes)`: Creates a Rating for the ratee in question and for the rater passed in the parameters.

`ratable.rater_rate(attributes)`: Creates a Rating for the rater in question and for the ratee passed in the parameters.

`ratee.ratings.by_rater(rater)`: `Ratable::Rating` scope that returns a ratee's ratings for a particular rater.

`rater.ratings.by_ratee(ratee)`: `Ratable::Rating` scope that returns a rater's ratings for a particular ratee.

`rater.ratees`: Returns all ratees for a given rater.

`ratee.raters`: Returns all raters for a given ratee.

`Model.acts_like_ratable?`: Checks whether a model uses Ratable.

`model.acts_like_ratable?`: Checks whether a model instance uses the Ratable.

`Model.acts_like_rater?`: Checks whether the model uses Ratable Rater.

`model.acts_like_rater?`: Checks whether a model instance uses Ratable Rater.

`Model.acts_like_ratee?`: Checks whether a model uses Ratable Ratee.

`mode.acts_like_ratee?`: Checks whether a model instance uses Ratable Ratee.
