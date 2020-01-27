//
//  UserGuideController.swift
//  TriggerStop
//
//  Created by T.J. Stone on 1/26/20.
//  Copyright © 2020 T.J. Stone. All rights reserved.
//

import QuickLook

/**
 Displays the user guide document in a Quick Look Preview Controller.
 
 Disables the share button to prevent kids from sending communications
 to other people.
 */
class UserGuideController: QLPreviewController {
    
    /**
    Hides the share button in the top right corner of the QuickLook controller.
    
    Need to do this to prevent children from sending messages to other people
    via QuickLook's share feature.
    */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true )
        //This hides the share item
        if let add =  self.children.first as? UINavigationController {
            if let layoutContainerView  = add.view.subviews[1] as? UINavigationBar {
                 layoutContainerView.subviews[1].subviews[1].isHidden = true
            }
        }
    }
}
