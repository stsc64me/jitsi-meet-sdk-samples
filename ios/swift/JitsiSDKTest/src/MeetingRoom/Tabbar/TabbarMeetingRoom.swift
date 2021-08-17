//
//  TabbarMeetingRoom.swift
//  App
//
//  Created by Sittisak Teanpanom on 10/8/2564 BE.
//  Copyright © 2564 BE Atlassian Inc. All rights reserved.
//

import Foundation
import UIKit
import DropDown
class TabbarMeetingRoom: UITabBarController, UITabBarControllerDelegate {
    
    var menu :DropDown = {
        let menu = DropDown()
        menu.dataSource = ["Mic", "Sound", "Video", "Hand"]
        let image = ["Mic", "Sound", "Video", "Hand"]
        menu.cellNib = UINib(nibName: "MenuDropDownCell", bundle: nil)
        menu.customCellConfiguration = {index, title, cell in
            guard let cell = cell as? MenuDropDownCell else {return }
            if #available(iOS 13.0, *) {
                cell.imageDropdown.image = UIImage(systemName: image[index])
            } else {
                // Fallback on earlier versions
            }
        }
        return menu
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // tell our UITabBarController subclass to handle its own delegate methods
        self.delegate = self
        let myView = tabBar

        navigationController?.navigationBar.topItem?.titleView = myView
        guard let bottomView = navigationController?.navigationBar.topItem?.titleView else { return }
        
        menu.anchorView = bottomView
        menu.selectionAction = {index, title in
            print("index",index,title)
            if index == 0 {
                
            }else if index == 1 {
                
            }else if index == 2 {
                
            }else if index == 3 {
                
            }
        }
    }
    
    // called whenever a tab button is tapped
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       
    }

    // alternate method if you need the tab bar item
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        menu.show()
    }
    
    func alert(message: String, title: String = "") -> UIAlertController? {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .default, handler: nil)
      alertController.addAction(OKAction)
      present(alertController, animated: true, completion: nil)
      return alertController
    }
}
