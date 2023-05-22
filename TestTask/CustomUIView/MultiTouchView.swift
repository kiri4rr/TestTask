//
//  MultiTouchView.swift
//  TestTask
//
//  Created by Kirill Romanenko on 21.05.2023.
//

import UIKit
import SwiftUI

struct MultiTouchUIView : UIViewRepresentable {
    typealias UIViewType = MultiTouchView
    
    var onTouchBegan: ((Set<UITouch>, UIEvent?) -> Void)?
    var onTouchEnded: ((Set<UITouch>, UIEvent?) -> Void)?
    
    func makeUIView(context: Context) -> MultiTouchView {
        let view = MultiTouchView()
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        view.onTouchBegan = onTouchBegan
        view.onTouchEnded = onTouchEnded
        return view
    }
    
    func updateUIView(_ uiView: MultiTouchView, context: Context) {
        
    }

}

class MultiTouchView : UIView {
    
    var onTouchBegan: ((Set<UITouch>, UIEvent?) -> Void)?
    var onTouchEnded: ((Set<UITouch>, UIEvent?) -> Void)?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        onTouchBegan?(touches, event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        onTouchEnded?(touches, event)
    }
}


