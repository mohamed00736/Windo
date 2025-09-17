//
//  FilesViewModel.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//

import Foundation

class FilesViewModel: ObservableObject {
  @Published var filesState: UiState<[SpaceFile]> = .idle
  @Published var currentSpace: Space? = nil
  
  private let networkService = NetworkService.shared
  
  init() {}
  
  @MainActor
  func loadFiles(for space: Space) async {
    if currentSpace?.name == space.name,
       case .success = filesState {
      return
    }
    
    currentSpace = space
    filesState = .loading
    
    do {
      let fileNames = try await networkService.fetchFiles(for: space.name)
      let files = fileNames.map { SpaceFile(name: $0) }
      filesState = .success(files)
    } catch {
      filesState = .failed(error.localizedDescription)
    }
  }
  
  func clearError() {
    if case .failed = filesState {
      filesState = .idle
    }
  }
  
  func clearFiles() {
    filesState = .idle
    currentSpace = nil
  }
}
