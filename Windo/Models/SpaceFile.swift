//
//  SpaceFile.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//


import Foundation

struct SpaceFile: Identifiable, Equatable , Hashable {
    let id: UUID
    let name: String
    let fileExtension: String
}
