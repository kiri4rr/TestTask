//
//  ParametersOfZones.swift
//  TestTask
//
//  Created by Kirill Romanenko on 20.05.2023.
//

import SwiftUI

class ParametersOfZones: ObservableObject {
    @Published var heightOfFirstZone: CGFloat = 0
    @Published var heightOfSecondZone: CGFloat = 0
    
    func hideSecondZone() {
        heightOfSecondZone = 0
    }
}
