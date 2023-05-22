//
//  ViewWithTextFields.swift
//  TestTask
//
//  Created by Kirill Romanenko on 23.05.2023.
//

import SwiftUI

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

