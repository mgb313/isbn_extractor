module ISBN
  class PdfReader < Reader
    def initialize path
      @reader = PDF::Reader.new(path) rescue NullReader.new
    end

    def extract_isbns
      data = extract_isbn @reader.pages.first(10)
      data = extract_isbn @reader.pages.first(20).last(10) if data.empty?
      data = extract_isbn @reader.pages.last(30) if data.empty?
      data
    end

    protected

    def extract_isbn pages
      parse_match_data pages.collect { |page| page.text.match(regexps) }
    end
  end
end