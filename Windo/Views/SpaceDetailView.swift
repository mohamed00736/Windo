  //
  //  SpaceDetailView.swift
  //  Windo
  //
  //  Created by hacinemed on 17/09/2025.
  //


import SwiftUI

struct SpaceFilesListView: View {
  let files: [SpaceFile]
  @Binding var hoveredIndex: Int?
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      LazyVStack(alignment: .leading, spacing: 4) {
        ForEach(Array(files.enumerated()), id: \.element.id) { idx, file in
          SpaceFileRow(file: file, isHovered: hoveredIndex == idx)
            .onHover { inside in
              hoveredIndex = inside ? idx : nil
            }
        }
        
      }
      .padding(.horizontal, 12)
      .padding(.bottom, 10)
    }
    .clipped()
  }
}

struct SpaceHeaderView: View {
  @Binding var back: Bool
  var spaceName: String
  
  var body: some View {
    HStack {
      Button(action: { back = true }) {
        Image(systemName: "arrow.left")
          .font(.title2)
          .foregroundColor(.black)
      }
      .buttonStyle(PlainButtonStyle())
      Text(spaceName)
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(.black)
    }
    .padding(.top, 8)
    .padding(.leading, 24)
  }
}


struct SpacePagerIndicator: View {
  var currentIndex: Int
  var total: Int
  
  var body: some View {
    HStack(spacing: 8) {
      ForEach(0..<total, id: \.self) { idx in
        Circle()
          .fill(idx == currentIndex ? Color.gray : Color.gray.opacity(0.5))
          .frame(width: 8, height: 8)
      }
    }
  }
}


struct SpaceDetailView: View {
  @EnvironmentObject var spacesVM: SpacesViewModel
  @Binding var back: Bool
  @State private var hoveredIndex: Int? = nil
  
  var currentSpaceIndex: Int? {
    spacesVM.spaces.firstIndex(where: { $0.id == spacesVM.selectedSpace?.id })
  }
  var currentSpace: Space? {
    guard let idx = currentSpaceIndex else { return nil }
    return spacesVM.spaces[idx]
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
      
      
      SpaceFilesListView(files: currentSpace?.files ?? [], hoveredIndex: $hoveredIndex)
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
        Color.white.opacity(0.24)
        
      }
      
    )
    
    .contentShape(Rectangle())
    .gesture(
      DragGesture()
        .onEnded { value in
          guard let idx = currentSpaceIndex else { return }
          if value.translation.width < -50 && idx < spacesVM.spaces.count - 1 {
            withAnimation {
              spacesVM.selectedSpace = spacesVM.spaces[idx + 1]
            }
          }
          if value.translation.width > 50 && idx > 0 {
            withAnimation {
              spacesVM.selectedSpace = spacesVM.spaces[idx - 1]
            }
          }
        }
    )
    .onAppear {
        // usingg keyboardd to swtch between spaces in detals screen
      NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
        guard let idx = currentSpaceIndex else { return event }
        if event.keyCode == 123 && idx > 0 {
          spacesVM.selectedSpace = spacesVM.spaces[idx - 1]
        }
        if event.keyCode == 124 && idx < spacesVM.spaces.count - 1 {
          spacesVM.selectedSpace = spacesVM.spaces[idx + 1]
        }
        return event
      }
    }
    .transition(.opacity)
  }
}
