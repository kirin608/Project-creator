require "fileutils"

    def generate
      p 'Enter root directory path: '
      user_root_path = gets.chomp
  
      user_root_path = FileUtils.mkdir("./#{user_root_path}").first unless %w[. ./].include? user_root_path
  
      FileUtils.cd(user_root_path)
      FileUtils.mkdir(['lib', 'spec'])
  
      gemfile = File.open('./Gemfile', 'w+')
      gemfile.close
  
      p 'Enter the name of any classes you want to include in your project: '
      user_classes_names = gets.chomp.split(' ')
  
      user_classes_names.each do |class_name|
        File.open("./#{class_name.downcase}.rb", 'w+') do |file|
          file.write  <<~ruby
              class #{class_name.capitalize}
              end
          ruby
        end
  
        File.open("./spec/#{class_name.downcase}_spec.rb", 'w+') do |file|
          file.write  <<~spec
              require '#{class_name.downcase}'
  
              describe(#{class_name.capitalize}) do
              end
          spec
        end
      end
    end
    generate