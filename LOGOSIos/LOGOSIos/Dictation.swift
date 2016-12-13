//
//  Dictation.swift
//  LOGOSIos
//
//  Created by Ganna Shulika on 04/12/2016.
//  Copyright © 2016 Ganna Shulika. All rights reserved.
//

import Foundation

class Dictation {
    
    enum Status {
        case wrong
        case correct
        case start
    }
    
    var words : [WordData]
    
    
    var wrongWords : [WordData]
    var counter = 0, correctCounter = 0
    var status = Status.start
    
    init(words : [WordData]) {
        self.words = words
        self.wrongWords = [WordData]()
    }
    
    init(words : [WordData], numWords : Int) {
        self.words = [WordData]()
        self.wrongWords = [WordData]()
        var idx = Array(0...(words.count - 1))
        for _ in 1...numWords {
            let i = Int(arc4random_uniform(UInt32(idx.count)))
            self.words.append(words[idx.remove(at: i)])
        }
    }
    
    func numTotalWords() -> Int {
        return words.count
    }
    
    func numWrongWords() -> Int {
        return wrongWords.count
    }
    
    func numCorrectWords() -> Int {
        return correctCounter
    }
    
    func currentWord() -> String? {
        if (counter >= words.count) {
            return nil
        }
        return words[counter].word
    }
    
    func currentContext() -> String? {
        if (counter >= words.count) {
            return nil
        }
        return words[counter].context
    }
    
    func tryWord(_ word : String) {
        let isCorrect = (currentWord() == word)
        if isCorrect {
            counter += 1
            if status == .correct || status == .start {
                correctCounter += 1
            }
            status = .correct
        } else {
            if status == .correct || status == .start {
                wrongWords.append(words[counter])
            }
            status = .wrong
        }
    }
    
    func getWord(_ index : Int) -> WordData {
        return words[index]
    }
    
    func getStatus() -> Status {
        return status
    }
    
    func isFinished() -> Bool {
        return (counter >= words.count)
    }
    
    func getWrongWords() -> [WordData] {
        return wrongWords
    }
}
