# frozen_string_literal: true

module LeaveIt
  class CLI
    def self.run(path)
      gemfile = File.join(path, 'Gemfile')
      lockfile = File.join(path, 'Gemfile.lock')

      unless File.exist?(gemfile) && File.exist?(lockfile)
        puts "❌ Gemfile or Gemfile.lock not found in #{path}"
        exit(1)
      end

      versions = parse_lockfile_versions(lockfile)
      updated = update_gemfile_versions(gemfile, versions)
      File.write(gemfile, updated)

      puts "✅ Gemfile in #{path} updated successfully."
    end

    def self.parse_lockfile_versions(lockfile)
      versions = {}
      File.foreach(lockfile) { |line| process_lockfile_line(line, versions) }
      versions
    end

    def self.update_gemfile_versions(gemfile, lock_versions)
      new_lines = []
      File.foreach(gemfile) { |line| new_lines << process_gemfile_line(line, lock_versions) }
      new_lines.join
    end

    def self.process_lockfile_line(line, versions)
      @in_gem_section ||= false
      @in_gem_section = true if gem_section_start?(line)
      return unless @in_gem_section

      if gem_line?(line)
        gem_name, version = parse_gem_line(line)
        versions[gem_name] = version
      elsif line.strip.empty?
        @in_gem_section = false
      end
    end

    def self.process_gemfile_line(line, lock_versions)
      if gem_declaration_line?(line)
        indent, gem_name, _, version, rest = parse_gem_declaration_line(line)

        if version.nil? && lock_versions[gem_name]
          version_str = pessimistic_version(lock_versions[gem_name])
          return "#{indent}gem '#{gem_name}', '#{version_str}'#{rest}\n"
        end
      end

      line
    end

    def self.gem_section_start?(line)
      line.strip == 'GEM'
    end

    def self.gem_line?(line)
      line =~ /^\s{4}(\S+)\s\(([^)]+)\)/
    end

    def self.parse_gem_line(line)
      match = line.match(/^\s{4}(\S+)\s\(([^)]+)\)/)
      [match[1], match[2]]
    end

    def self.gem_declaration_line?(line)
      line =~ /^(\s*)gem ['"]([^'"]+)['"](,\s*['"]([^'"]+)['"])?(.*)$/
    end

    def self.parse_gem_declaration_line(line)
      match = line.match(/^(\s*)gem ['"]([^'"]+)['"](,\s*['"]([^'"]+)['"])?(.*)$/)
      [match[1], match[2], match[3], match[4], match[5]]
    end

    def self.pessimistic_version(version)
      parts = version.split('.')
      if parts.length >= 3
        "~> #{parts[0]}.#{parts[1]}.#{parts[2]}"
      else
        "~> #{version}"
      end
    end
  end
end
