//
//  ShadowView.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//


import SwiftUI

struct ShadowView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let shadowView = NSBox()
        shadowView.boxType = .custom
        shadowView.isTransparent = true
        shadowView.borderType = .noBorder
//      shadowView.backgroundColor = .clear
        
        // Configure shadow to match image settings
        let shadow = NSShadow()
        shadow.shadowColor = NSColor.black.withAlphaComponent(0.15) // 25% opacity
        shadow.shadowOffset = NSSize(width: 0, height: 0.59) // Y offset
        shadow.shadowBlurRadius = 14.64 // Blur
        
        shadowView.shadow = shadow
        return shadowView
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        // No update needed for static shadow
    }
}
