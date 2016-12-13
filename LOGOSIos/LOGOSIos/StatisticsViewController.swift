//
//  StatisticsViewController.swift
//  LOGOSIos
//
//  Created by Ganna Shulika on 06/12/2016.
//  Copyright © 2016 Ganna Shulika. All rights reserved.
//

import UIKit

class StatisticsViewController: BaseViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
         addSlideMenuButton()
        let topViewController : UIViewController = self.navigationController!.topViewController!
        topViewController.title = "Statistiken"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
