//
//  extensions.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/7/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView{
    func circleImage() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
    }
}
