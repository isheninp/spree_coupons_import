module SpreeCouponsImport
  module_function

  # Returns the version of the currently loaded SpreeCouponsImport as a
  # <tt>Gem::Version</tt>.
  def version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 1
    MINOR = 2
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].compact.join('.')
  end
end
