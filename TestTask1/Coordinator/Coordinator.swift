//
//  Coordinator.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 22.10.2021.
//

import Foundation
import UIKit

enum Event {
    case buttonTapped
}

protocol Coordinator {
    
    var navigationController: UINavigationController? { get set }
    
    func eventOccured(with type: Event)
    func start()
}

protocol Coordinanating {
    
    var coordinator: Coordinator? { get set }
    
}
