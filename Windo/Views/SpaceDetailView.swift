  //
  //  SpaceDetailView.swift
  //  Windo
  //
  //  Created by hacinemed on 17/09/2025.
  //


import SwiftUI

struct SpaceFilesListView: View {
  let filesState: UiState<[SpaceFile]>
  @Binding var hoveredIndex: Int?
  let onRetry: () -> Void
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      LazyVStack(alignment: .leading, spacing: 4) {
        switch filesState {
        case .idle:
          EmptyView()
        case .loading:
          VStack {
            ProgressView()
              .scaleEffect(0.8)
            Text("Loading files...")
              .font(.system(size: 12))
              .foregroundColor(.gray)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding(.top, 40)
        case .success(let files):
          if files.isEmpty {
            VStack {
              Image(systemName: "folder")
                .foregroundColor(.gray)
                .font(.title2)
              Text("No files in this space")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 40)
          } else {
            ForEach(Array(files.enumerated()), id: \.element.id) { idx, file in
              SpaceFileRow(file: file, isHovered: hoveredIndex == idx)
                .onHover { inside in
                  hoveredIndex = inside ? idx : nil
                }
            }
          }
        case .failed(let errorMessage):
          VStack {
            Image(systemName: "exclamationmark.triangle")
              .foregroundColor(.red)
              .font(.title2)
            Text("Error: \(errorMessage ?? "Unknown error")")
              .font(.system(size: 12))
              .foregroundColor(.red)
              .multilineTextAlignment(.center)
            Button("Retry") {
              onRetry()
            }
            .buttonStyle(.bordered)
            .controlSize(.small)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding(.top, 40)
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
              print("🔄 [SpaceFilesListView] No current space index")
              return 
            }
            
            if value.translation.width < -50 && idx < spacesVM.spaces.count - 1 {
              print("🔄 [SpaceFilesListView] Swiping to next space: \(idx + 1)")
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
              print("🔄 [SpaceFilesListView] Swiping to previous space: \(idx - 1)")
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
        print("🔍 [SpaceDetailView] currentSpace: \(currentSpace?.name ?? "nil")")
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
        Color.white.opacity(0.24)
        
      }
      
    )
    
    .contentShape(Rectangle())
    .onAppear {
        // usingg keyboardd to swtch between spaces in detals screen
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
