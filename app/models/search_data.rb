class SearchData < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
 
  settings analysis: {
    filter: {
      ngram_filter: {
        type: "nGram",
        min_gram: 3,
        max_gram: 8
      }
    },
    analyzer: {
      ngram_analyzer: {
        tokenizer: "lowercase",
        filter: ["ngram_filter"],
        type: "custom"
      }
    }
  } do
    mapping do
      [:record_name, :record_body].each do |attribute|
        indexes attribute, type: 'string', analyzer: 'ngram_analyzer'
      end
    end
  end
  
   
end
