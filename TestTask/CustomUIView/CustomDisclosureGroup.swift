//
//  CustomDisclosureGroup.swift
//  TestTask
//
//  Created by Kirill Romanenko on 19.05.2023.
//

import SwiftUI


struct CustomDisclosureGroup<Label, Content> : View where Label: View, Content: View {
    
    @Binding var isExpanded: Bool
    
    private let label: () -> Label
    private let content: () -> Content
    
    init(isExpanded: Binding<Bool>,
         @ViewBuilder label: @escaping () -> Label,
         @ViewBuilder content: @escaping () -> Content) {
        self._isExpanded = isExpanded
        self.label = label
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 8, content: {
            Button(action: {
                isExpanded.toggle()
            }) {
                label()
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(15.0)

            if isExpanded {
                content()
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
        })
    }
    
    func hideMainView() {
        self.isExpanded = false
    }
}
