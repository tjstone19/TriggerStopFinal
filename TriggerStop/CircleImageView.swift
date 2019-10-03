//
//  CircleImageView.swift
//  TriggerStop
//
//  Created by T.J. Stone on 10/1/19.
//  Copyright © 2019 T.J. Stone. All rights reserved.
//

import UIKit

/**
 * CircleImageView is an ImageView that displays itself as a circle.
 * CircleImageView sets the cornerRadius each time the bounds of the
 * imageview change.
 */
class CircleImageView: UIImageView {
    var horizontalConstraint: NSLayoutConstraint?
    var verticalConstraint: NSLayoutConstraint?
    
    /**
     * Updates the corner radius each time the ImageView bound's change.
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.width / 2.0
    }
}
