//
//  ExpandeableView.swift
//  TestTask
//
//  Created by Kirill Romanenko on 23.05.2023.
//

import SwiftUI

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
                            if let error = setParamatersOfLocationAndFrameOfZoneView(width: width,
                                                                                     height: height,
                                                                                     x: x,
                                                                                     y: y) {
                                setAlert(alertMessage: error)
                                return
                            }
                            
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
    
    private func setParamatersOfLocationAndFrameOfZoneView(width: String, height: String, x: String, y: String) -> AlertConstants? {
        
        guard let width = Float(width), (0 ... Int.max).contains(Int(width)) else {
            return .errorOfWidth
        }
        guard let height = Float(height), (0 ... Int.max).contains(Int(height)) else {
            return .errorOfHeight
        }
        guard let x = Float(x), (Int.min ... Int.max).contains(Int(x)) else {
            return .errorOfx
        }
        guard let y = Float(y), (Int.min ... Int.max).contains(Int(y)) else {
            return .errorOfy
        }
        
        parametersOfZones.heightOfFirstZone = CGFloat(2 * height / 3)
        parametersOfZones.heightOfSecondZone = CGFloat(height / 3)
        parametersOfZone.width = CGFloat(width)
        parametersOfZone.height = CGFloat(height)
        parametersOfZone.x = CGFloat(x)
        parametersOfZone.y = CGFloat(y)
        
        return nil
    }
    
    private func setAlert(alertMessage: AlertConstants) {
        self.alertMessage = alertMessage
        self.isShowAlert.toggle()
    }
}
