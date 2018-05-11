class RecognitionError < StandardError
end

class MismatchedTokenError < RecognitionError
end

class NoViableAltError < RecognitionError
end

