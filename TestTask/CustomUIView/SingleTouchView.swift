//
//  SingleTouchView.swift
//  TestTask
//
//  Created by Kirill Romanenko on 21.05.2023.
//

import UIKit
import SwiftUI

struct SingleTouchUIView : UIViewRepresentable {
    typealias UIViewType = SingleTouchView
    
    var onTouchBegan: (() -> Void)?
    var onTouchEnded: (() -> Void)?
    
    func makeUIView(context: Context) -> SingleTouchView {
        let view = SingleTouchView()
        view.onTouchBegan = onTouchBegan
        view.onTouchEnded = onTouchEnded
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = false
        return view
    }
    
    func updateUIView(_ uiView: SingleTouchView, context: Context) {
        
    }

}

class SingleTouchView : UIView {
    
    var onTouchBegan: (() -> Void)?
    var onTouchEnded: (() -> Void)?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.count)
        if touches.count == 1 {
            super.touchesBegan(touches, with: event)
            onTouchBegan?()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.count)
        if touches.count == 1 {
            super.touchesEnded(touches, with: event)
            onTouchEnded?()
        }
    }
}
