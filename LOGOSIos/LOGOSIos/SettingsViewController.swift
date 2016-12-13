//
//  SettingsViewController.swift
//  LOGOSIos
//
//  Created by Ganna Shulika on 06/12/2016.
//  Copyright © 2016 Ganna Shulika. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{

   
    var settingsCells = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         addSlideMenuButton()
        let topViewController : UIViewController = self.navigationController!.topViewController!
        topViewController.title = "Einstellungen"

        
        settingsCells = ["Nutzer wechseln","Ansage konfigurieren"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = settingsCells[indexPath.row]
        
        return cell!
    }
    
   

}
