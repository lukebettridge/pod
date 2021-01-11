//
//  UIDevice.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
