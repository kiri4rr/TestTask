//
//  ParametersOfZone.swift
//  TestTask
//
//  Created by Kirill Romanenko on 20.05.2023.
//

import SwiftUI

class ParametersOfZone: ObservableObject{
    @Published var width: CGFloat = 300
    @Published var height: CGFloat = 400
    @Published var x: CGFloat = 200
    @Published var y: CGFloat = 400
}
