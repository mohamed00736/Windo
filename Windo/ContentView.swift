//
//  ContentView.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//

  import SwiftUI

  struct ContentView: View {
      @EnvironmentObject var spacesVM: SpacesViewModel

      var body: some View {
          ZStack {
              if let _ = spacesVM.selectedSpace {
                SpaceDetailView( back: Binding(get: {
                      false
                  }, set: { value in
                      if value { spacesVM.selectedSpace = nil }
                  }))
                .transition(.asymmetric(
                                        insertion: .opacity.animation(.easeIn(duration: 0.3)),  // fade in
                                        removal: .opacity.animation(.easeOut(duration: 0.3))   // fade out
                                    ))
              } else {
                  SpacesListView()
                  .transition(.asymmetric(
                                          insertion: .opacity.animation(.easeIn(duration: 0.3)),  // fade in
                                          removal: .opacity.animation(.easeOut(duration: 0.3))   // fade out
                                      ))
              }
          }.frame(maxWidth: .infinity , maxHeight: .infinity)
          .animation(.easeInOut(duration: 0.2), value: spacesVM.selectedSpace)
        
      }
  }





  #Preview {
      ContentView().environmentObject(SpacesViewModel())
  }


