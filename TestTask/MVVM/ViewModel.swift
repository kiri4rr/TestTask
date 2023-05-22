//
//  ViewModel.swift
//  TestTask
//
//  Created by Kirill Romanenko on 18.05.2023.
//

import Foundation


class ViewModel: TwoZoneHandler {
    
    private var positions: [Int: (Double, Double, Int)] = [:]
    private var index = 0
    
    func onBlueZoneEvent(isPressed: Bool) {
        switch isPressed {
        case true:
            print("Blue zone touch down")
        case false:
            print("Blue zone touch up")
        }
    }
    
    func onYellowZoneEvent(idx: Int, x: Double, y: Double, hash: Int) {
        print("On yellow zone touch")
        print(idx)
        print(x)
        print(y)
        var wasAdded = false
        var incrementIndex = idx
        var decrementIndex = idx
        if positions.keys.contains(idx) {
                while !wasAdded {
                    incrementIndex += 1
                    decrementIndex -= 1
                    if !positions.keys.contains(decrementIndex) && decrementIndex > 0 {
                        positions[decrementIndex] = (x, y, hash)
                        wasAdded = true
                    } else if !positions.keys.contains(incrementIndex) {
                        positions[incrementIndex] = (x, y, hash)
                        wasAdded = true
                    }
                }
        } else {
            positions[idx] = (x, y, hash)
        }
        print(positions.keys.sorted())
    }
    
    func deleteFingerPosition(x: Double, y: Double, hash: Int){
        guard let positionIndex = positions.firstIndex(where: { $0.value.2 == hash || ($0.value.0 == x && $0.value.1 == y) }) else { return }
        positions.remove(at: positionIndex)
    }
    
    func getProcentToWidthAndHeight(x: Double, width: Double, y: Double, height: Double) -> (Double, Double){
        let procentToWidth: Double = getProcent(value: x,
                                                  toValue: width)
        let procentToHeight: Double = getProcent(value: y,
                                                   toValue: height)
        return (procentToWidth, procentToHeight)
    }
    
    private func getProcent(value: Double, toValue: Double) -> Double {
        return (value / toValue) * 100
    }
    
}
