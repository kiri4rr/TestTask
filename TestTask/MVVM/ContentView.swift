//
//  ContentView.swift
//  TestTask
//
//  Created by Kirill Romanenko on 18.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    let viewModel = ViewModel()
    
    @StateObject var parametersOfZone: ParametersOfZone = ParametersOfZone()
    @StateObject var parametersOfZones: ParametersOfZones = ParametersOfZones()
    
    @State private var isShowSecondZone = true
    
    var body: some View {
        ZStack {
            if parametersOfZone.width != 0 && parametersOfZone.height != 0 {
                ZoneView(viewModel: viewModel, parametersOfZone: parametersOfZone, parametersOfZones: parametersOfZones, isHidden: $isShowSecondZone)
                    .padding()
            }
            VStack(alignment: .center, spacing: 10, content: {
                ExpandeableView(parametersOfZone: parametersOfZone, parametersOfZones: parametersOfZones)
                Toggle(isOn: $isShowSecondZone, label: {
                    Text("Is second zone show?")
                })
                .onChange(of: isShowSecondZone, perform: { value in
                    if !value {
                        parametersOfZones.heightOfSecondZone = 0
                        parametersOfZones.heightOfFirstZone = parametersOfZone.height
                    } else {
                        parametersOfZones.heightOfFirstZone = 2 * parametersOfZone.height / 3
                        parametersOfZones.heightOfSecondZone = parametersOfZone.height / 3
                    }
                })
                Spacer()
            })
        }
    }
}

struct ExpandeableView: View {
    
    @State private var isExpanded = false
    
    @State var width: String = ""
    @State var height: String = ""
    @State var x: String = ""
    @State var y: String = ""
    @State private var isShowAlert: Bool = false
    @State private var alertMessage: AlertConstants?
    
    @ObservedObject var parametersOfZone: ParametersOfZone
    @ObservedObject var parametersOfZones: ParametersOfZones
    
    
    var body: some View {
        VStack(alignment: .center, content: {
            
            let firstGroupOfTextFields = ViewWithTextFields(firstValue: $width, secondValue: $height, placeholder1: "Enter width", placeholder2: "Enter height")
            let secondGroupOfTextFields = ViewWithTextFields(firstValue: $x, secondValue: $y, placeholder1: "Enter x", placeholder2: "Enter y")
            
            CustomDisclosureGroup(
                isExpanded: $isExpanded,
                label:{
                    Text("Click to show parameters of ZoneView")
                }, content: {
                    VStack {
                        firstGroupOfTextFields
                        secondGroupOfTextFields
                        Button(action: {
                            guard let width = Float(width), (0 ..< Int.max).contains(Int(width)) else {
                                setAlert(alertMessage: .errorOfWidth)
                                return }
                            guard let height = Float(height), (0 ..< Int.max).contains(Int(height)) else {
                                setAlert(alertMessage: .errorOfHeight)
                                return
                            }
                            guard let x = Float(x), (Int.min ..< Int.max).contains(Int(x)) else {
                                setAlert(alertMessage: .errorOfx)
                                return
                            }
                            guard let y = Float(y), (Int.min ..< Int.max).contains(Int(y)) else {
                                setAlert(alertMessage: .errorOfy)
                                return
                            }
                            
                            parametersOfZones.heightOfFirstZone = CGFloat(2 * height / 3)
                            parametersOfZones.heightOfSecondZone = CGFloat(height / 3)
                            parametersOfZone.width = CGFloat(width)
                            parametersOfZone.height = CGFloat(height)
                            parametersOfZone.x = CGFloat(x)
                            parametersOfZone.y = CGFloat(y)
                            
                            isExpanded.toggle()
                            
                        }, label: {
                            Text("Enter")
                        })
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10.0)
                        .alert(isPresented: $isShowAlert, content: {
                            Alert(title: Text("Error input"), message: Text(alertMessage?.rawValue ?? ""), dismissButton: .default(Text("Ok")))
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    }
                    .padding()
                }
            )
        })
        .padding()
        
    }
    
    private func setAlert(alertMessage: AlertConstants) {
        self.alertMessage = alertMessage
        self.isShowAlert.toggle()
    }
}

struct ViewWithTextFields: View {
    
    @Binding var firstValue: String
    @Binding var secondValue: String
    
    var placeholder1: String
    var placeholder2: String
    
    var body: some View {
        VStack(alignment: .center,
               spacing: 8,
               content: {
                TextField(placeholder1, text: $firstValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .onChange(of: firstValue, perform: { value in
                        let filtered = value.filter{ "-0123456789".contains($0) }
                        if filtered != value {
                            firstValue = filtered
                        }
                    })
                TextField(placeholder2, text: $secondValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .onChange(of: secondValue, perform: { value in
                        let filtered = value.filter{ "-0123456789".contains($0) }
                        if filtered != value {
                            secondValue = filtered
                        }
                    })
               })
    }
}

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
                    
                    MultiTouchUIView { (touches, event) in
                        print("Count of touches = \(touches.count)")
                        proccessTouchDown(touches)
                    } onTouchEnded: { (touches, event) in
                        print("Count of touches = \(touches.count)")
                        proccessTouchUp(touches)
                    }
                    .frame(width: parametersOfZone.width,
                           height: parametersOfZones.heightOfFirstZone)
                    .background(Color.yellow)
                    
                    
                    SingleTouchUIView {
                        viewModel.onBlueZoneEvent(isPressed: true)
                    } onTouchEnded: {
                        viewModel.onBlueZoneEvent(isPressed: false)
                    }
                    .frame(width: parametersOfZone.width,
                           height: parametersOfZones.heightOfSecondZone)
                    .background(Color.blue)
                    
                }
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            )
            .position(x: parametersOfZone.x, y: parametersOfZone.y)
    }
    
    private func proccessTouchDown(_ touches: Set<UITouch>){
        print("Touch on multitouch's view was began \n")
        var index = 0
        touches.forEach { (touch) in
            print(touch.hash)
            let position = touch.location(in: nil)
            let procentToWidth: Double = viewModel.getProcent(value: Double(position.x),
                                                      toValue: Double(parametersOfZone.width))
            let procentToHeight: Double = viewModel.getProcent(value: Double(position.y),
                                                       toValue: Double(parametersOfZones.heightOfFirstZone))
            viewModel.onYellowZoneEvent(idx: index, x: procentToWidth, y: procentToHeight, hash: touch.hash)
            index += 1
        }

    }
    
    private func proccessTouchUp(_ touches: Set<UITouch>) {
        print("Touch on multitouch's view was ended \n")
        touches.forEach { (touch) in
            print(touch.hash)
            let position = touch.location(in: nil)
            print(touch.hashValue)
            let procentToWidth: Double = viewModel.getProcent(value: Double(position.x),
                                                      toValue: Double(parametersOfZone.width))
            let procentToHeight: Double = viewModel.getProcent(value: Double(position.y),
                                                       toValue: Double(parametersOfZones.heightOfFirstZone))
            viewModel.deleteFingerPosition(x: procentToWidth, y: procentToHeight, hash: touch.hash)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
