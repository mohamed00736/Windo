//
//  VisualEffectView.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//


import SwiftUI

extension View {
    public static func semiOpaqueWindow() -> some View {
        VisualEffect().ignoresSafeArea()
    }
}

struct VisualEffect : NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSVisualEffectView()
//      view.state = .active
      view.material = .mediumLight // for soft whit blurr
      view.blendingMode = .behindWindow

        return view
    }
    func updateNSView(_ view: NSView, context: Context) { }
}

