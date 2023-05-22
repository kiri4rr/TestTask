//
//  ParametersOfZones.swift
//  TestTask
//
//  Created by Kirill Romanenko on 20.05.2023.
//

import SwiftUI

class ParametersOfZones: ObservableObject {
    @Published var heightOfFirstZone: CGFloat = 266.66
    @Published var heightOfSecondZone: CGFloat = 133.33
    
    func hideSecondZone() {
        heightOfSecondZone = 0
    }
}
