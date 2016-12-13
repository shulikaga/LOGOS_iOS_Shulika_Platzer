//
//  ResultView.swift
//  LOGOSIos
//
//  Created by Ganna Shulika on 04/12/2016.
//  Copyright © 2016 Ganna Shulika. All rights reserved.
//

import Foundation
import UIKit

class ResultView: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numCorrectWordsLabel: UILabel!
    @IBOutlet weak var numWrongWordsLabel: UILabel!
    @IBOutlet weak var totalNumWordsLabel1: UILabel!
    @IBOutlet weak var totalNumWordsLabel2: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    var wrongWords : [WordData]!

    var numCorrectWords = 0
    var numWrongWords = 0
    var numTotalWords = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(wrongWords != nil){
            return wrongWords.count
        }else{
            return 0;
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = wrongWords[indexPath.item].word
        return cell
    }
    

    override func viewDidLoad() {
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        
        numWrongWordsLabel.text = String(numWrongWords)
        numCorrectWordsLabel.text = String(numCorrectWords)
        totalNumWordsLabel1.text = String(numTotalWords)
        totalNumWordsLabel2.text =  totalNumWordsLabel1.text
        
        
        if wrongWords.count == 0 {
            
            titleLabel.text = "Alle Wörter waren richtig!"
            table.isHidden = true
            retryButton.isHidden = true
        }

    }

    
    
}
