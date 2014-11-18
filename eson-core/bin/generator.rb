require 'thor'
require 'eson-core'

class GeneratorCLI < Thor
  desc "generate", "Generates a Ruby class file from a API description in JSON"
  option :input,  aliases: '-i', type: :string, required: true, desc: "Specifies the input JSON file"
  option :output, aliases: '-o', type: :string, retuired: true, desc: "Specifies the generated output ruby file"
  def generate
    input_name = options[:input]
    hash = JSON.parse(File.read(input_name))
    name, root = hash.first
    args = {
      name:          name,
      url:           root.fetch('url'),
      methods:       root.fetch('methods'),
      body:          root.fetch('body'),
      documentation: root.fetch('documentation')
    }
    generated = Eson::Transform::Generator.new(args).ruby_content
    output_file = options[:output] || File.basename(input_name, File.extname(input_name)) + ".rb"
    File.open(output_file, 'w') { |f| f.write(generated) }
  end
end

GeneratorCLI.start(ARGV)
