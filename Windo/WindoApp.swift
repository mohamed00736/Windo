  //
  //  WindoApp.swift
  //  Windo
  //
  //  Created by hacinemed on 17/09/2025.
  //

import SwiftUI

@main
struct WindoApp: App {
  @StateObject private var spacesVM = SpacesViewModel()
  var body: some Scene {
    WindowGroup {

      ContentView()
        .background(
          VisualEffect().ignoresSafeArea() 
        )
        .background( ShadowView().ignoresSafeArea())
        .background( TransparentWindow().ignoresSafeArea())
        .environmentObject(spacesVM)
        .background(Color.white.opacity(1))
        .onAppear {
          DispatchQueue.main.async {
            for window in NSApplication.shared.windows {
              window.isOpaque = false
              
              window.backgroundColor = .clear

            }
          }
        }
    }
    .windowStyle(.hiddenTitleBar)
           .windowResizability(.contentSize)
          
  }
}

struct TransparentWindow: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            view.window?.isOpaque = false
            view.window?.backgroundColor = .clear
//            view.window?.hasShadow = true // Keeps the standard window shadow
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}
