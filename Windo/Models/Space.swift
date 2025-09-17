//
//  Space.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//


import Foundation

struct Space: Identifiable, Equatable , Hashable {
    let id: UUID
    let name: String
    let files: [SpaceFile]
    
    init(name: String, files: [SpaceFile] = []) {
        self.id = UUID()
        self.name = name
        self.files = files
    }
}
