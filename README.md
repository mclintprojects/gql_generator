# GQL

A better Rails generator for GraphQL-Ruby.

# Installation

Add `'gem gql_generator'` to your development gem group.

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
