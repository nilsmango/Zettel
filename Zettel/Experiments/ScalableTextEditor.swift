//
//  ScalableTextEditor.swift
//  Zettel
//
//  Created by Simon Lang on 08.09.2024.
//

import SwiftUI
import UIKit

struct ScalableTextEditor: UIViewRepresentable {
    @Binding var text: String
    var font: UIFont
    var minimumScaleFactor: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        updateTextViewFont(uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private func updateTextViewFont(_ textView: UITextView) {
        let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: .greatestFiniteMagnitude))
        let newFont: UIFont
        
        if size.height > textView.bounds.height {
            let scaleFactor = max(minimumScaleFactor, textView.bounds.height / size.height)
            newFont = font.withSize(font.pointSize * scaleFactor)
        } else {
            newFont = font
        }
        
        if textView.font != newFont {
            textView.font = newFont
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: ScalableTextEditor
        
        init(_ parent: ScalableTextEditor) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.updateTextViewFont(textView)
        }
    }
}
