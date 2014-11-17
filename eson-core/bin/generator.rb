require 'thor'
require 'eson-core'

class GeneratorCLI < Thor
  desc "generate", "Generates a Ruby class file from a API description in JSON"
  option :input,  aliases: '-i', type: :string, required: true, desc: "Specifies the input JSON file"
  option :output, aliases: '-o', type: :string, retuired: true, desc: "Specifies the generated output ruby file"
  def generate
    hash = JSON.parse(File.read(options[:input]))
    name, root = hash.first
    args = {
      name:          name,
      url:           root.fetch('url'),
      methods:       root.fetch('methods'),
      body:          root.fetch('body'),
      documentation: root.fetch('documentation')
    }
    generated = Converter.new(args).ruby_content
    File.open(options[:output], 'w') { |f| f.write(generated) }
  end
end

GeneratorCLI.start(ARGV)
