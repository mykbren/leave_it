# frozen_string_literal: true

require 'spec_helper'
require 'fileutils'
require 'leave_it/cli'

RSpec.describe LeaveIt::CLI do
  describe '.update_gemfile_versions' do
    let(:gemfile_content) do
      <<~GEMFILE
        source 'https://rubygems.org'

        gem 'rake'
        gem 'rspec', '~> 3.10'
      GEMFILE
    end

    let(:lock_versions) do
      {
        'rake' => '13.0.6',
        'rspec' => '3.12.0'
      }
    end

    it 'adds pessimistic versions to gems without versions' do
      allow(File).to receive(:foreach).and_call_original
      allow(File).to receive(:foreach).with('Gemfile').and_yield("source 'https://rubygems.org'\n")
                                      .and_yield("gem 'rake'\n")
                                      .and_yield("gem 'rspec', '~> 3.10'\n")

      result = described_class.update_gemfile_versions('Gemfile', lock_versions)

      expect(result).to include("gem 'rake', '~> 13.0.6'")
      expect(result).to include("gem 'rspec', '~> 3.10'")
    end
  end
end
