//
//  ParametersOfZone.swift
//  TestTask
//
//  Created by Kirill Romanenko on 20.05.2023.
//

import SwiftUI

class ParametersOfZone: ObservableObject{
    @Published var width: CGFloat = 0
    @Published var height: CGFloat = 0
    @Published var x: CGFloat = 0
    @Published var y: CGFloat = 0
}
