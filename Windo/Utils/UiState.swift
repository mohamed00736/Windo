import Foundation

public enum UiState<Model> {
    case idle
    case loading
    case success(Model)
    case failed(String?)

    public var data: Model? {
        if case let .success(a) = self {
            return a
        } else {
            return nil
        }
    }
}

extension UiState: Equatable where Model: Equatable {
    public static func == (lhs: UiState<Model>, rhs: UiState<Model>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case let (.success(a), .success(b)):
            return a == b
        case let (.failed(a), .failed(b)):
            return a == b
        default:
            return false
        }
    }
}
