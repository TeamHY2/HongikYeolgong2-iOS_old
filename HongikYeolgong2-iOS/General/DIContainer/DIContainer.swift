

import Foundation

final class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    var dependencies: [String: Any] = [:]
    
    func register<Dependency>(type key: Dependency.Type, service: Any) {
        #if DEBUG
        print(#function + " \(key) is registered")
        #endif
        dependencies["\(key)"] = service
    }
    
    func resolve<Dependency>() -> Dependency {
        let key = Dependency.self
        #if DEBUG
        print(#function + " \(key) is resolved")
        #endif
        return dependencies["\(key)"] as! Dependency
    }
}
