//
//  NetworkService.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//

  //
  //  NetworkService.swift
  //  Windo
  //
  //  Created by hacinemed on 17/09/2025.
  //

  import Foundation

  class NetworkService: ObservableObject {
      static let shared = NetworkService()
      
      private let baseURL = "http://84.247.189.50:3333"
      private let bearerToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJ1c2VyXzMxMmZwNFZWRXZsTDBuU0t5c3hqcGY3TXdBeiIsImVtYWlsIjoib2JhZGFhbHNoYXJpZjNAZ21haWwuY29tIiwiZmlyc3ROYW1lIjoiT2JhZGEiLCJsYXN0TmFtZSI6IkNoYXJpZiIsImlhdCI6MTc1NDc0MDA3Nn0.Tb8Q7dEm83p4WAipdibIjR_kFdcqXDMU-5-o0SRBatM"
      
      private init() {}

      private func makeRequest<T: Codable>(endpoint: String, responseType: T.Type) async throws -> T {
          guard let url = URL(string: "\(baseURL)\(endpoint)") else {
             
              throw NetworkError.invalidURL
          }
          
          var request = URLRequest(url: url)
          request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          
      
          
          let (data, response) = try await URLSession.shared.data(for: request)
          
          guard let httpResponse = response as? HTTPURLResponse else {
           
              throw NetworkError.invalidResponse
          }
          
      
          
          if httpResponse.statusCode != 200 {
              if let responseString = String(data: data, encoding: .utf8) {
                  print("Respns \(responseString)")
              }
              throw NetworkError.invalidResponse
          }
                  
          do {
              let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            
              return decodedResponse
          } catch {
              print("ERORr \(error)")
              throw NetworkError.decodingError
          }
      }
      
     
      func fetchSpaces() async throws -> [String] {
          let response: SpacesResponse = try await makeRequest(endpoint: "/spaces", responseType: SpacesResponse.self)
          return response.spaces
      }
      
      func fetchFiles(for spaceName: String) async throws -> [String] {
          let encodedSpaceName = spaceName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? spaceName
          let endpoint = "/files/user_312fp4VVEvlL0nSKysxjpf7MwAz/\(encodedSpaceName)"
          
         
          print("Space name: '\(spaceName)'")
          print("Encoded space name: '\(encodedSpaceName)'")
          
          let response: FilesResponse = try await makeRequest(endpoint: endpoint, responseType: FilesResponse.self)
          return response.files
      }
  }

 
  enum NetworkError: Error, LocalizedError {
      case invalidURL
      case invalidResponse
      case noData
      case decodingError
      
      var errorDescription: String? {
          switch self {
          case .invalidURL:
              return "Invalid URL"
          case .invalidResponse:
              return "Invalid response from server"
          case .noData:
              return "No data received"
          case .decodingError:
              return "Failed to decode response"
          }
      }
  }
