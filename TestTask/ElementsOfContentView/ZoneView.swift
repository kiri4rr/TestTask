//
//  ZoneView.swift
//  TestTask
//
//  Created by Kirill Romanenko on 23.05.2023.
//

import SwiftUI

struct ZoneView: View {
    
    var viewModel: ViewModel
    
    @ObservedObject var parametersOfZone: ParametersOfZone
    @ObservedObject var parametersOfZones: ParametersOfZones
    
    @State private var firstSomeText = ""
    @State private var secondSomeText = ""
    
    @Binding var isHidden: Bool
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: parametersOfZone.width,
                   height: parametersOfZone.height)
            .cornerRadius(25.0)
            .overlay(RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.black, lineWidth: 5))
            .background(
                VStack(spacing: 5){
                    multiView
                    singleView
                }
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            )
            .position(x: parametersOfZone.x, y: parametersOfZone.y)
    }
    
    var multiView: some View {
        MultiTouchUIView { (touches, event, view) in
            proccessTouchDown(touches, view)
        } onTouchEnded: { (touches, event, view) in
            proccessTouchUp(touches, view)
        }
        .frame(width: parametersOfZone.width,
               height: parametersOfZones.heightOfFirstZone)
        .background(Color.yellow)
    }
    
    var singleView: some View {
        SingleTouchUIView {
            viewModel.onBlueZoneEvent(isPressed: true)
        } onTouchEnded: {
            viewModel.onBlueZoneEvent(isPressed: false)
        }
        .frame(width: parametersOfZone.width,
               height: parametersOfZones.heightOfSecondZone)
        .background(Color.blue)
    }
    
    private func proccessTouchDown(_ touches: Set<UITouch>, _ view: UIView?){
        var index = 0
        touches.forEach { (touch) in
            let position = touch.location(in: view)
            let procentValuesOfFrame = viewModel.getProcentToWidthAndHeight(x: Double(position.x),
                                                                            width: Double(parametersOfZone.width),
                                                                            y: Double(position.y),
                                                                            height: Double(parametersOfZones.heightOfFirstZone))
            viewModel.onYellowZoneEvent(idx: index,
                                        x: procentValuesOfFrame.0,
                                        y: procentValuesOfFrame.1,
                                        hash: touch.hash)
            index += 1
        }
        
    }
    
    private func proccessTouchUp(_ touches: Set<UITouch>, _ view: UIView?) {
        touches.forEach { (touch) in
            let position = touch.location(in: view)
            let procentValuesOfFrame = viewModel.getProcentToWidthAndHeight(x: Double(position.x),
                                                                            width: Double(parametersOfZone.width),
                                                                            y: Double(position.y),
                                                                            height: Double(parametersOfZones.heightOfFirstZone))
            viewModel.deleteFingerPosition(x: procentValuesOfFrame.0,
                                           y: procentValuesOfFrame.1,
                                           hash: touch.hash)
        }
    }
}
