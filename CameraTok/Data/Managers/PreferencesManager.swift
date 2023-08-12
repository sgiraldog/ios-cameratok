import Foundation

class PreferencesManager {
    static let shared = PreferencesManager()
    
    private let defaults: UserDefaults = .standard
    
    func setIntroPresented(value: Bool = true) {
        defaults.set(value, forKey: PreferenceKey.introPresented.rawValue)
    }
    
    func isIntroPresented() -> Bool {
        return defaults.bool(forKey: PreferenceKey.introPresented.rawValue)
    }
}

extension PreferencesManager {
    enum PreferenceKey: String {
        case introPresented
    }
}
