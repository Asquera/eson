require 'fileutils'
require 'thor'
require 'eson-core'

module Helpers
  def setup_dir(output_folder, overwrite)
    if Dir.exists?(output_folder)
      if !options['overwrite']
        raise ArgumentError, "Folder #{output_folder} exists"
      end
    end
    Dir.mkdir(output_folder) unless Dir.exists?(output_folder)
  end

  def get_base_name(filename)
    File.basename(filename, File.extname(filename))
  end

  def folder_name(filename)
    basename = get_base_name(filename)
    names = basename.split('.').slice(0..-2)
    names << 'core' if names.empty?
    File.join(names)
  end

  def short_name(filename)
    basename = get_base_name(filename)
    names = basename.split('.')
    names.slice!(0..-2)
    names.first
  end

  def transform(filename)
    unless File.exists?(filename)
      raise "File #{filename} does not exists"
    end
    hash = JSON.parse(File.read(filename))
    name, root = hash.first
    args = {
      name:            name,
      url:             root.fetch('url'),
      request_methods: root['methods'],
      body:            root['body'],
      documentation:   root['documentation']
    }
    Eson::Transform::Generator.new(args)
  end
end

class GeneratorCLI < Thor
  include Helpers

  desc "transform", "Generates a Ruby class file from a API description in JSON"
  option :input,  aliases: '-i', type: :string, required: true, desc: "Specifies the input JSON file"
  option :output, aliases: '-o', type: :string, retuired: true, desc: "Specifies the generated output ruby file"
  def transform_file
    generated   = transform(options[:input]).description
    output_file = options[:output] || ruby_file_name(input_name)
    File.open(output_file, 'w') { |f| f.write(generated) }
  end

  desc "generate", "Takes JSON files from a folder and generate ruby files into another folder"
  option :input_folder,  aliases: '-i', type: :string, required: true, desc: "Specifies the input folder with JSON files"
  option :output_folder, aliases: '-o', type: :string, required: true, desc: "Specifies the output folder for all generated ruby files"
  option :overwrite,                    type: :boolean, required: false, desc: "If set it overwrites the content of the output folder"
  def generate
    json_files = Dir.glob(File.join(options[:input_folder], '**/*.json'))
    output_folder = File.absolute_path(options.fetch('output_folder'))

    setup_dir(output_folder, options['overwrite'])

    # generate all ruby contents for all files put into a map
    # create folders / files
    result = {}
    json_files.each do |file|
      STDOUT.puts "Transforming file #{file}"
      result[file] = transform(file).description
    end

    # write folders / files
    result.each do |file, content|
      folder = File.join(output_folder, folder_name(file))

      output_file = File.join(folder, short_name(file)) + ".rb"
      unless Dir.exists?(folder) || folder.empty?
        Dir.mkdir(folder)
      end

      STDOUT.puts "writing file: #{output_file}"
      File.open(output_file, "w") { |f| f.write(content) }
    end
  end

  desc "requests", "Generates HTTP requests ruby files"
  option :input_folder,  aliases: '-i', type: :string,  required: true,  desc: "Specifies the input folder with API descriptions in Ruby"
  option :output_folder, aliases: '-o', type: :string,  required: true,  desc: "Specifies output folder where to put HTTP request ruby files"
  option :overwrite,                    type: :boolean, required: false, desc: "If set it overwrites the content of the output folder"
  def requests_http
    json_files = Dir.glob(File.join(options[:input_folder], '**/*.json'))
    output_folder = File.absolute_path(options.fetch('output_folder'))

    setup_dir(output_folder, options['overwrite'])

    result = {}
    json_files.each do |file|
      STDOUT.puts "FILE: #{file}"
      result[file] = transform(file).request
    end

    result.each do |file, content|
      folder = File.join(output_folder, folder_name(file))

      output_file = File.join(folder, short_name(file)) + ".rb"
      unless Dir.exists?(folder) || folder.empty?
        Dir.mkdir(folder)
      end

      STDOUT.puts "writing file: #{output_file}"
      File.open(output_file, "w") { |f| f.write(content) }
    end
  end
end

GeneratorCLI.start(ARGV)
