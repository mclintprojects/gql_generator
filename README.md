# GQL

A better Rails generator for GraphQL-Ruby.

# Installation

Add `'gem gql_generator'` to your development gem group.

Add the following to the end of your spec/rails_helper.rb

```ruby
def gql_response(response, mutation_name)
  JSON.parse(response.body)["data"][mutation_name]
end
```

Create the following files

```ruby
# app/graphql/mutations/base_mutation.rb
module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    field :status, Integer, null: false
    field :errors, [Types::ErrorType], null: true

    protected

    def respond(status, options = {})
      options[:errors] = options[:error].present? ?
        generate_errors(options[:error]) : nil

      { status: status, **options }
    end

    private

    def generate_errors(errors)
      result = []
      errors.each do |key, value|
        result.push({property: key, message: value})
      end

      result
    end
  end
end
```

```ruby
# app/graphql/types/error_type.rb
module Types
  class ErrorType < Types::BaseObject
    field :property, String, null: false
    field :message, String, null: false
  end
end
```

## Usage

rails generate gql mutation_name --type --arguments --fields

### Parameters

#### Type

Can be either `object`, `input`, `mutation`

#### Arguments

1. Must be colon-separated. Eg: name:data_type:required -> title:string:true
2. Can have multiple arguments that are ' ' separated. Eg: title:string:true description:string:false

#### Fields

1. Must be colon-separated. Eg: name:data_type:required -> title:string:true
2. Can have multiple arguments that are ' ' separated. Eg: title:string:true description:string:false

| GQL data type | GraphQL type                    |
| ------------- | ------------------------------- |
| id            | ID                              |
| string        | String                          |
| int           | Int                             |
| bool          | Boolean                         |
| float         | Float                           |
| date          | GraphQL::Types::ISO8601Date     |
| datetime      | GraphQL::Types::ISO8601DateTime |
