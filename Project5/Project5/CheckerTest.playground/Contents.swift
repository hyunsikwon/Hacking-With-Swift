import UIKit

func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    // This is an iOS class that is designed to spot spelling errors, which makes it perfect for knowing if a given word is real or not.
    
    let range = NSRange(location: 0, length: word.utf16.count)
    print("range = \(range)")
    // This is used to store a string range, which is a value that holds a start position and a length. We want to examine the whole string, so we use 0 for the start position and the string's length for the length.
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    print("misspelledRange.location = \(misspelledRange.location)")
    print("NSNotFound = \(NSNotFound)")
    if misspelledRange.location == NSNotFound {
        return true
    } else {
        return false
    }
    
}
isReal(word: "phone")
isReal(word: "phoei")
isReal(word: "apple")
