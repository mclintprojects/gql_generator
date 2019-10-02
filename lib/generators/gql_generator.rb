require 'rails/generators'

class GqlGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)
  argument :name, type: :string, required: true
  class_option :arguments, type: :array, required: true, default: []
  class_option :fields, type: :array, required: true, default: []
  class_option :type, type: :string, default: "mutation"
  
  def generate
    case options[:type]
    when "mutation"
      generate_mutation_files
    when "object"
      generate_type_files
    when "input"
      generate_input_file
    end
  end

  private

  TYPES = {
    id: "ID",
    int: "Int",
    string: "String",
    float: "Float",
    bool: "Boolean",
    date: "GraphQL::Types::ISO8601Date",
    datetime: "GraphQL::Types::ISO8601DateTime",
    json: "GraphQL::Types::JSON",
  }.freeze

  def generate_mutation_files
    ensure_required_params_present :fields, :arguments, ->(){
      template "mutation_file.template",
        "app/graphql/mutations/#{name}.rb"
      template "mutation_spec.template",
        "spec/graphql/mutations/#{name}_spec.rb"
    }
  end

  def generate_type_files
    ensure_required_params_present :fields, ->(){
      template "type_file.template",
        "app/graphql/types/#{name}_type.rb"
      template "type_spec.template",
        "spec/graphql/queries/#{name}_type_spec.rb"
    }
  end

  def generate_input_file
    ensure_required_params_present :fields, ->(){
      template "input_file.template",
        "app/graphql/input/#{name}_input.rb"
    }
  end

  def arguments
    options[:arguments].map do |argument|
      argument_options = argument.split(":")
      OpenStruct.new(
        name: argument_options[0],
        type: type_of(argument_options[1]),
        required: argument_options[2] || "true",
        should_quote?: !["int", "float", "boolean", "id"].include?(argument_options[1]),
      )
    end
  end

  def fields
    options[:fields].map do |field|
      field_options = field.split(":")
      OpenStruct.new(
        name: field_options[0],
        type: type_of(field_options[1]),
        null: field_options[2] || "false"
      )
    end
  end

  def type_of(type)
    type = type ||= "string"
    TYPES.fetch(type.to_sym, "String")
  end

  def ensure_required_params_present(*required_params, callback)
    required_params_present = true

    required_params.each do |param|
      if send(param).empty?
        puts "'#{param.to_s}' parameter is required."
        required_params_present = false
      end
    end

    callback.call unless !required_params_present
  end
end
  