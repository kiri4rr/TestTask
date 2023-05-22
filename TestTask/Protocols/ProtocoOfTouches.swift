//
//  ProtocoOfTouches.swift
//  TestTask
//
//  Created by Kirill Romanenko on 21.05.2023.
//

import Foundation

protocol TwoZoneHandler {
    func onBlueZoneEvent(isPressed: Bool)
    func onYellowZoneEvent(idx: Int,
                           x: Double,
                           y: Double,
                           hash: Int)
}
