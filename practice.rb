# method to reverse a sentence - e.g. "The sky is blue" becomes "blue is sky The"

def rev_sent(str)
  osent = str.dup
  nsent = str.dup

  i = str.length
  j = k = 0

  while i >= 0
    if osent[i] == " "
      nsent[k..k+j] = osent[i..i+j]
      k += j
      i -= 1
      j = 1
    else
      i -= 1
      j += 1
    end
  end

  # populate last word
  nsent[k+1..str.length] = osent[0..j]
  # remove leading whitespace and trailing garbage characters
  nsent = nsent[1..str.length]

  return nsent
end

# run method for testing
puts rev_sent("The sky is blue")
