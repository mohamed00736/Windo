//
//  SpaceFilesListView.swift
//  Windo
//
//  Created by hacinemed on 18/09/2025.
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
