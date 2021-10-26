//
//  addSubviews.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 23.10.2021.
//

import Foundation
import UIKit

// MARK: addSubviews
extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
