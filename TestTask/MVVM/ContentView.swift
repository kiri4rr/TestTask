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
                        .padding(.leading, 8)
                })
                .onChange(of: isShowSecondZone, perform: { value in
                    if !value {
                        setParametersOfZones(parametersOfZone.height, 0)
                    } else {
                        setParametersOfZones(2 * parametersOfZone.height / 3,
                                             parametersOfZone.height / 3)
                    }
                })
                Spacer()
            })
        }
    }
    
    private func setParametersOfZones(_ heightOfFirstZone: CGFloat, _ heightOfSecondZone: CGFloat){
        parametersOfZones.heightOfFirstZone = heightOfFirstZone
        parametersOfZones.heightOfSecondZone = heightOfSecondZone
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
