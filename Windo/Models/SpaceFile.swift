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
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.fileExtension = SpaceFile.getFileExtension(from: name)
    }
    
    private static func getFileExtension(from fileName: String) -> String {
        let components = fileName.components(separatedBy: ".")
        guard components.count > 1 else { return "unknown" }
        
        let ext = components.last?.lowercased() ?? "unknown"
        
        // Map common file extensions to our supported types
        switch ext {
        case "pdf":
            return "pdf"
        case "doc", "docx":
            return "doc"
        case "jpg", "jpeg", "png", "gif", "bmp", "tiff", "webp", "mov", "mp4", "avi", "mkv" ,"svg":
            return "img"
        case "mp3", "wav", "aac", "m4a", "flac":
            return "mic"
        case "txt", "rtf", "md":
            return "doc"
        case "web":
            return "web"
        default:
            return "unknown"
        }
    }
}
