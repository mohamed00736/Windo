//
//  SpacesViewModel.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//


import Foundation

class SpacesViewModel: ObservableObject {
    @Published var spacesState: UiState<[Space]> = .idle
    @Published var selectedSpace: Space? = nil
    
    private let networkService = NetworkService.shared
    
    var spaces: [Space] {
        spacesState.data ?? []
    }
    
    init() {
        Task {
            await loadSpaces()
        }
    }
    
    @MainActor
    func loadSpaces() async {
        spacesState = .loading
        
        do {
            let spaceNames = try await networkService.fetchSpaces()
            let spaces = spaceNames.map { Space(name: $0) }
            spacesState = .success(spaces)
        } catch {
            spacesState = .failed(error.localizedDescription)
            print("Error loading spaces: \(error)")
        }
    }
    
    func selectSpace(_ space: Space) {
        selectedSpace = space
    }
    
    func clearError() {
        if case .failed = spacesState {
            spacesState = .idle
        }
    }
}
