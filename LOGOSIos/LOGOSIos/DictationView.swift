//
//  DictationView.swift
//  LOGOSIos
//
//  Created by Ganna Shulika on 04/12/2016.
//  Copyright © 2016 Ganna Shulika. All rights reserved.
//
import AVFoundation
import Foundation
import UIKit

class DictationView: UIViewController,  UITextFieldDelegate{
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var progressBar: ProgressBar!
    
    
    
    let synth = AVSpeechSynthesizer()
    
    var word = AVSpeechUtterance(string: "")
    var context = AVSpeechUtterance(string: "")
    
    var dict: Dictation!
    let wordFlashTime = 2.0, feedbackFlashTime = 2.0
    var wordFlashTimer, feedbackFlashTimer : Timer?
    
    override func viewDidLoad() {
        textField.delegate = self
        manageTextField()
        textField.becomeFirstResponder()
        wordButtonPressed(self)
        
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.white
        textField.placeholder = nil
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        dict.tryWord(textField.text!)
        updateProgressBar()
        manageTextField()
        extraFeedback()
        wordButtonPressed(self)
        checkIfFinished()
    }
    
    
    func checkIfFinished() {
         print(dict.counter)
        if (dict.isFinished()) {
            
            Timer.scheduledTimer(timeInterval: feedbackFlashTime, target: self, selector: #selector(DictationView.gotoResultScreen), userInfo: nil, repeats: false)
        }
    }
    
    func gotoResultScreen() {

        
        let vc = storyboard?.instantiateViewController(withIdentifier: "resultView") as! ResultView
    
        vc.wrongWords = dict.getWrongWords()
        vc.numWrongWords = dict.numWrongWords()
        vc.numCorrectWords = dict.numCorrectWords()
        vc.numTotalWords = dict.numTotalWords()
        
        present(vc, animated: true, completion: nil)

    }
    

    
    /*  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     dict.tryWord(textField.text!)
     updateProgressBar()
     manageTextField()
     extraFeedback()
     checkIfFinished()
     wordButtonPressed(self)
     return true
     }*/
    
    func updateProgressBar() {
        let fracA = Double(dict.numCorrectWords()) / Double(dict.numTotalWords())
        let fracB = Double(dict.numWrongWords()) / Double(dict.numTotalWords())
        progressBar.updateValues(fracA, fracB: fracB)
    }
    
    
    
    
       func manageTextField() {
        textField.isHidden = false
        textField.text = nil
        if dict.currentWord() == nil {
            textField.resignFirstResponder()
            textField.isHidden = false
        } else if dict.status == .wrong {
            textField.backgroundColor = UIColor(red: 1, green: 0.8, blue : 0.8, alpha : 1)
            textField.text = nil
            textField.placeholder = dict.currentWord()
            textField.resignFirstResponder()
        }
    }
    
    func extraFeedback() {
        if dict.getStatus() == .correct {
            feedbackLabel.backgroundColor = UIColor.green
            feedbackLabel.text = "Correct"
            flashFeedbackLabel()
        } else if dict.getStatus() == .wrong {
            feedbackLabel.backgroundColor = UIColor.red
            feedbackLabel.text = "Wrong"
            flashFeedbackLabel()
        }
    }
    
    func flashFeedbackLabel() {
        if let fft = feedbackFlashTimer {
            fft.invalidate()
        }
        feedbackLabel.isHidden = true
        feedbackFlashTimer = Timer.scheduledTimer(timeInterval: feedbackFlashTime, target: self, selector: #selector(DictationView.hideFeedbackLabel), userInfo: nil, repeats: false)
    }
    
    func hideFeedbackLabel() {
        feedbackLabel.isHidden = true
    }
    
    func flashWordLabel() {
        if let wft = wordFlashTimer {
            wft.invalidate()
        }
        wordLabel.isHidden = true
        wordFlashTimer = Timer.scheduledTimer(timeInterval: wordFlashTime, target: self, selector: #selector(DictationView.hideWordLabel), userInfo: nil, repeats: false)
    }
    
    func changeVoiceTo(){
        word.voice = AVSpeechSynthesisVoice(language: "de-DE")
        context.voice = AVSpeechSynthesisVoice(language: "de-DE")
        
        word.pitchMultiplier = 1.2
        word.volume = 0.75
        word.rate = 0.4
        
        context.pitchMultiplier = 1.25
        context.volume = 0.75
        context.rate = 0.45
    }
    
    func hideWordLabel() {
        wordLabel.isHidden = true
    }
    
    
    @IBAction func wordButtonPressed(_ sender: Any) {
        
        if dict.currentWord() == nil {
            return
        }
        wordLabel.text = dict.currentWord()
        flashWordLabel()
        
        word = AVSpeechUtterance(string:  wordLabel.text!)
        changeVoiceTo()
        synth.speak(word)
    }
    
    @IBAction func contextButtonPressed(_ sender: Any) {
        if dict.currentContext() == nil {
            return
        }
        wordLabel.text = dict.currentContext()
        flashWordLabel()
        context = AVSpeechUtterance(string:  wordLabel.text!)
        
        changeVoiceTo()
        
        if(wordLabel.text?.contains("Ketchup"))!{
            let idx1 = wordLabel.text?.index((wordLabel.text?.startIndex)!, offsetBy: 15)
            let idx2 = wordLabel.text?.index((wordLabel.text?.startIndex)!, offsetBy: 23)
            
            context = AVSpeechUtterance(string: (wordLabel.text?.substring(to: idx1!))!)
            context.voice = AVSpeechSynthesisVoice(language: "de-DE")
            synth.speak(context)
            
            context = AVSpeechUtterance(string: "Ketchup")
            context.voice = AVSpeechSynthesisVoice(language: "en-US")
            context.pitchMultiplier = 1.0
            context.volume = 1.2
            context.rate = 0.4
            synth.speak(context)
            
            context = AVSpeechUtterance(string: (wordLabel.text?.substring(from: idx2!))!)
            context.voice = AVSpeechSynthesisVoice(language: "de-DE")
            synth.speak(context)
            
            
        }else{
            synth.speak(context)
        }

    }
    
    

}
