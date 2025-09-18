  //
  //  SpaceDetailView.swift
  //  Windo
  //
  //  Created by hacinemed on 17/09/2025.
  //


import SwiftUI

struct SpaceDetailView: View {
  @EnvironmentObject var spacesVM: SpacesViewModel
  @StateObject private var filesVM = FilesViewModel()
  @Binding var back: Bool
  @State private var hoveredIndex: Int? = nil
  
  var currentSpaceIndex: Int? {
    guard let selectedSpace = spacesVM.selectedSpace else { return nil }
    return spacesVM.spaces.firstIndex(where: { $0.name == selectedSpace.name })
  }
  var currentSpace: Space? {
    return spacesVM.selectedSpace
  }
  
  var body: some View {
    VStack(alignment : .leading,spacing: 0) {
      
      VStack(alignment : .leading, spacing: 0) {
        SpaceHeaderView(back: $back, spaceName: currentSpace?.name ?? "")
        
        Divider().background(.gray.opacity(0.4))
          .padding(.vertical, 8)
          .padding(.horizontal, 16)
      }
      .background(Color.clear)
      
      
      SpaceFilesListView(
        filesState: filesVM.filesState,
        hoveredIndex: $hoveredIndex,
        onRetry: {
          if let space = currentSpace {
            Task {
              await filesVM.loadFiles(for: space)
            }
          }
        }
      )
      .gesture(
        DragGesture(minimumDistance: 20)
          .onEnded { value in
            guard let idx = currentSpaceIndex else {
             
              return 
            }
            
            if value.translation.width < -50 && idx < spacesVM.spaces.count - 1 {
              
              let nextSpace = spacesVM.spaces[idx + 1]
              withAnimation {
                spacesVM.selectedSpace = nextSpace
              }
              // Load files for the new space
              Task {
                await filesVM.loadFiles(for: nextSpace)
              }
            }
            if value.translation.width > 50 && idx > 0 {
              let previousSpace = spacesVM.spaces[idx - 1]
              withAnimation {
                spacesVM.selectedSpace = previousSpace
              }
              // Load files for the new space
              Task {
                await filesVM.loadFiles(for: previousSpace)
              }
            }
          }
      )
      .onAppear {
        if let space = currentSpace {
          Task {
            await filesVM.loadFiles(for: space)
          }
        }
      }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      
      
      
      VStack(spacing: 0) {
        Divider()
        HStack {
          GeneralButton(image:  "slider.horizontal.3")
          Spacer()
          SpacePagerIndicator(currentIndex: currentSpaceIndex ?? 0, total: spacesVM.spaces.count)
          Spacer()
          GeneralButton(image: "paperclip")
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 12)
      }
      .background(Color.clear)
    }
    
    .background(
      ZStack {
        
        Rectangle.semiOpaqueWindow()
        .cornerRadius(0)
        Color.clear
      }
    )
    
    .contentShape(Rectangle())
    .onAppear {
        // Keybord button to switch betwen spaces
      NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
        guard let idx = currentSpaceIndex else { return event }
        if event.keyCode == 123 && idx > 0 {
          let previousSpace = spacesVM.spaces[idx - 1]
          spacesVM.selectedSpace = previousSpace
          Task {
            await filesVM.loadFiles(for: previousSpace)
          }
        }
        if event.keyCode == 124 && idx < spacesVM.spaces.count - 1 {
          let nextSpace = spacesVM.spaces[idx + 1]
          spacesVM.selectedSpace = nextSpace
          Task {
            await filesVM.loadFiles(for: nextSpace)
          }
        }
        return event
      }
    }
    .transition(.opacity)
  }
}
