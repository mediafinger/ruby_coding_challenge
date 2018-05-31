# Data model draft

```ruby
class User
  has_many :challenges, inverse_of: "creator"
  has_many :tasks, inverse_of: "creator"
  has_many :rating_aggregators, inverse_of: "creator"
  has_many :rating_methods, inverse_of: "creator"
  has_many :specs, inverse_of: "creator"
  has_many :solutions
  has_many :tasks, through: :solutions

  email
  name
  nick
  image
  url
  provider
  provider_uid
end

class Challenge
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :rating_aggregator

  has_many :tasks

  description
  open_from
  open_until
end

class Task
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :challenge
  belongs_to :rating_method

  has_many :solutions
  has_many :users, through: :solutions
  has_many :requirements
  has_many :specs, through: :requirements

  description
  open_from
  open_until
end

class Solution
  belongs_to :user
  belongs_to :task

  code
  rating
end

class Requirements
  belongs_to :task
  belongs_to :spec
end

class Spec
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_many :requirements
  has_many :tasks, through: :requirements

  code
end

class RatingMethod
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  code
  description
end

class RatingAggregator
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  code
  description
end
```
