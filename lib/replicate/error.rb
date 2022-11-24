module Replicate
  class ReplicateException < StandardError; end

  class ReplicateError(ReplicateException) 
    "An Error from Replicate."
  end

  class ModelError(ReplicateException) 
    "An error from user's code in a model."
  end

end