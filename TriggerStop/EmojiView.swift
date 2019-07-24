//
//  EmojiView.swift
//  TriggerStop
//
//  Created by T.J. Stone on 7/23/19.
//  Copyright © 2019 T.J. Stone. All rights reserved.
//

import Foundation
import UIKit

class EmojiView: UIImageView {
    // Determines if the emoji has been touched yet.
    let hasBeenTouched = Atomic<Bool>(false)
}
