class WrfRunner < Formula
  desc "A collection of structures used throughout my libraries."
  @@jar_name="WRFRunner.jar"
  @@project_url="https://github.com/Toberumono/WRF-Runner"
  homepage "#{@@project_url}"
  revision 1

  url "#{@@project_url}.git", :tag => "1.1"

  depends_on :java => "1.8+"
  depends_on "ant" => :build
  depends_on "wget"
  depends_on "namelist-parser"

  def install
    system "ant", "-Dprefix=\"./\"", "-Dlibs=\"#{HOMEBREW_PREFIX}/lib\""
    lib.install "#{@@jar_name}"
    if !(etc/"wrf-runner").exist?
      mkdir_p etc/"wrf-runner"
    end
    if !(etc/"wrf-runner/configuration.json").exist?
      mv "configuration.json", etc/"wrf-runner/configuration.json"
    end
    #Yeah, this is messing, but fucking hell, Homebrew likes to make things execute only.
    cp "wrf-linker.sh", "#{HOMEBREW_PREFIX}/bin/wrf-linker.sh"
  end

  def caveats
    <<-EOS.undent
      There are two ways to use this program.
      You can either run it from #{HOMEBREW_PREFIX}/lib/#{@@jar_name}, or,
      you can run "wrf-linker.sh <directory from which you want to run WRFRunner>".
      I highly reccomend the second option.
    EOS
  end
end
