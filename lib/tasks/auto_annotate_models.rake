# frozen_string_literal: true

# NOTE: only doing this in development as some production environments (Heroku)
#   are sensitive to local FS writes, and besides -- it's just not proper
#   to have a dev-mode tool do its thing in production.
if Rails.env.development?
  require "annotate"

  task set_annotation_options: :environment do
    Annotate.set_defaults(
      "routes" => "false",
      "models" => "true",
      "position_in_routes" => "after",
      "position_in_class" => "after",
      "position_in_test" => "after",
      "position_in_fixture" => "after",
      "position_in_factory" => "after",
      "position_in_serializer" => "after",
      "show_foreign_keys" => "true",
      "show_indexes" => "true",
      "simple_indexes" => "false",
      "model_dir" => "app/models",
      "root_dir" => "",
      "include_version" => "false",
      "require" => "",
      "exclude_tests" => "true",
      "exclude_fixtures" => "false",
      "exclude_factories" => "false",
      "exclude_serializers" => "true",
      "exclude_scaffolds" => "true",
      "exclude_controllers" => "true",
      "exclude_helpers" => "true",
      "ignore_model_sub_dir" => "false",
      "ignore_columns" => nil,
      "ignore_routes" => nil,
      "ignore_unknown_models" => "false",
      "hide_limit_column_types" => "integer,boolean",
      "skip_on_db_migrate" => "false",
      "format_bare" => "true",
      "format_rdoc" => "false",
      "format_markdown" => "false",
      "sort" => "false",
      "force" => "false",
      "trace" => "false",
      "wrapper_open" => nil,
      "wrapper_close" => nil,
    )
  end

  Annotate.load_tasks
end
