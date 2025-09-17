//
//  SpaceViewModel.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//


import Foundation

class SpaceViewModel: ObservableObject {
    @Published var space: Space
    @Published var selectedFileIndex: Int = 0

    init(space: Space) {
        self.space = space
    }
    
    var files: [SpaceFile] {
        space.files
    }
}