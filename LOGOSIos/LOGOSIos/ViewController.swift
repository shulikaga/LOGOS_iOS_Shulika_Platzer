//
//  ViewController.swift
//  LOGOSIos
//
//  Created by Ganna Shulika on 28/11/2016.
//  Copyright © 2016 Ganna Shulika. All rights reserved.
//

import UIKit

class ViewController: BaseViewController  {
    
   
    @IBOutlet weak var numWordsSlider: UISlider!
    @IBOutlet weak var numWordsLabel: UILabel!
    @IBOutlet weak var maxNumWordsLabel: UILabel!
    @IBOutlet weak var minNumWordsLabel: UILabel!
    
    var minNumWordsInt = 0
    var maxNumWordsInt = 0
    
    let wordData = [
        WordData(word: "barfuß",
                 context: "Wir gehen barfuß über die Wiese."),
        WordData(word: "brätst",
                 context: "Ich wollte Dich fragen, ob Du die Würstel am Griller oder in der Pfanne brätst."),
        WordData(word: "Bungalow",
                 context: "Ein Bungalow ist ein Haus ohne Stockwerke."),
        WordData(word: "diesig",
                 context: "Wir sehen nicht sehr weit, weil es diesig ist."),
        WordData(word: "dünn",
                 context: "Nur wer dünn ist kommt durch diesen Spalt."),
        WordData(word: "ein paar Mal",
                 context: "Das habe ich Dir schon ein paar Mal gesagt."),
        WordData(word: "fährst",
                 context: "Wo fährst Du mit dem Fahrrad hin?"),
        WordData(word: "fasst",
                 context: "Er fasst den Entschluss, das zu tun."),
        WordData(word: "fast",
                 context: "Der Ball hätte fast das Tor getroffen."),
        WordData(word: "Fenster",
                 context: "Zum Lüften öffne ich das Fenster."),
        WordData(word: "Fläche",
                 context: "Welche Fläche hat das Rechteck?"),
        WordData(word: "Majonäse",
                 context: "Ich mag lieber Ketchup als Majonäse."),
        WordData(word: "Nase",
                 context: "Ich rieche mit meiner Nase."),
        WordData(word: "nützlich",
                 context: "Regenwürmer sind nützlich, weil sie die Erde auflockern."),
        WordData(word: "pflügt",
                 context: "Der Traktor pflügt das Feld."),
        WordData(word: "Radieschen",
                 context: "Kannst Du bitte die Radieschen in Scheiben schneiden."),
        WordData(word: "schließlich",
                 context: "Nach der langen Wanderung kommen wir schließlich zum Gipfel."),
        WordData(word: "Sonne",
                 context: "Die Sonne scheint am blauen Himmel."),
        WordData(word: "Stoßzähne",
                 context: "Ein Elefant hat zwei große Stoßzähne."),
        WordData(word: "Tee",
                 context: "Grüner Tee ist gesund."),
        WordData(word: "türkis",
                 context: "Das Meer in Kailua ist türkis."),
        WordData(word: "Würste",
                 context: "Der Fleischhauer hat viele Würste."),
        WordData(word: "Zauberformel",
                 context: "Diese Zauberformel steht im Hexenbuch."),
        WordData(word: "Zylinder", 
                 context: "Früher trugen Männer einen Zylinder als Hut.")]
    
    func getMinNumWords() -> Int {
        return minNumWordsInt
    }
    
    func getMaxNumWords() -> Int {
        return maxNumWordsInt
    }
    
    func getNumWords() -> Int {
        return Int(round(numWordsSlider.value))
    }
    
    func setMaxNumWords(value:String){
        maxNumWordsInt = Int(value)!
    }
    
    func setMinNumWords(value:String){
        minNumWordsInt = Int(value)!
    }
    
    func updateLabels() {
        numWordsLabel.text = String(getNumWords())
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        updateLabels()
    }
        override func viewDidLoad() {
        super.viewDidLoad()
            addSlideMenuButton()
            let topViewController : UIViewController = self.navigationController!.topViewController!
            topViewController.title = "Ansage"
            
        // Do any additional setup after loading the view, typically from a nib.
            setMaxNumWords(value: maxNumWordsLabel.text!)
            setMinNumWords(value: minNumWordsLabel.text!)
            numWordsSlider.maximumValue = Float(min(getMaxNumWords(), wordData.count))
            numWordsSlider.value = numWordsSlider.maximumValue / 2
            updateLabels()
   
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController: DictationView = segue.destination as! DictationView
        DestViewController.dict = Dictation(words: wordData, numWords: getNumWords())
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        
    }
   
}

