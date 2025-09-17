//
//  SpacesViewModel.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//


import Foundation

class SpacesViewModel: ObservableObject {
  
  
  // am using moch data here instead of making network call
    @Published var spaces: [Space] = [
        Space(id: UUID(), name: "Space 1", files: [
            SpaceFile(id: UUID(), name: "Project brief", fileExtension: "doc"),
            SpaceFile(id: UUID(), name: "Inline work item creation", fileExtension: "pdf"),
            SpaceFile(id: UUID(), name: "Product roadmap", fileExtension: "doc"),
            SpaceFile(id: UUID(), name: "White board tool (tldra...)", fileExtension: "mic"),
            SpaceFile(id: UUID(), name: "White board tool (tldra...)", fileExtension: "mic"),
            SpaceFile(id: UUID(), name: "White board tool (tldra...)", fileExtension: "mic"),
      
            SpaceFile(id: UUID(), name: "White board tool (tldra...)", fileExtension: "mic"),
            SpaceFile(id: UUID(), name: "Email campaign providers", fileExtension: "chat"),
            SpaceFile(id: UUID(), name: "Inline work item creation", fileExtension: "cal"),
            SpaceFile(id: UUID(), name: "Inline work item creation", fileExtension: "cal"),
            SpaceFile(id: UUID(), name: "Inline work item creation", fileExtension: "cal"),
            SpaceFile(id: UUID(), name: "Inline work item creation", fileExtension: "cal"),
       
            SpaceFile(id: UUID(), name: "Inline work item creation", fileExtension: "cal"),
            SpaceFile(id: UUID(), name: "Inline work item creation", fileExtension: "cal"),
            SpaceFile(id: UUID(), name: "Screenshot.20250706", fileExtension: "img"),
        ]),
        Space(id: UUID(), name: "Space 2", files: [
            SpaceFile(id: UUID(), name: "Project plan", fileExtension: "doc"),
            SpaceFile(id: UUID(), name: "Design assets", fileExtension: "img"),
            SpaceFile(id: UUID(), name: "Inline work item creation", fileExtension: "cal"),

        ]),
        Space(id: UUID(), name: "Space 3", files: [
            SpaceFile(id: UUID(), name: "Campaign brief", fileExtension: "doc"),
            SpaceFile(id: UUID(), name: "White board tool (tldra...)", fileExtension: "mic"),
            SpaceFile(id: UUID(), name: "Email campaign providers", fileExtension: "chat"),
            SpaceFile(id: UUID(), name: "Inline work item creation", fileExtension: "cal"),
        ])
    ]
    @Published var selectedSpace: Space? = nil
}
