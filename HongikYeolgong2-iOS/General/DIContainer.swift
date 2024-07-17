

import Foundation

//class DIContainer: ObservableObject {
//    var services: ServiceType
//    
//    init(services: ServiceType) {
//        self.services = services
//    }
//}

//class DIContainer: ObservableObject {
//    static let shared = DIContainer()
//    
//    @Published private var services: [String: Any] = [:]
//
//    func register<T>(_ type: T.Type, instance: T) {
//        services[String(describing: type)] = instance
//    }
//
//    func resolve<T>(_ type: T.Type) -> T? {
//        return services[String(describing: type)] as? T
//    }
//}
//
//
//
//protocol authServiceType {
//    var authService: AuthenticationServiceType { get set }
//}
//
//class authService: authServiceType {
//    var authService: AuthenticationServiceType
//    
//}

final class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    var dependencies: [String: Any] = [:]
    
    func register<Dependency>(_ dependency: Dependency) {
        let key = String(describing: type(of: Dependency.self))
        #if DEBUG
        print(#function + " \(key) is registered")
        #endif
        dependencies[key] = dependency
    }
    
    func resolve<Dependency>() -> Dependency {
        let key = String(describing: type(of: Dependency.self))
        #if DEBUG
        print(#function + " \(key) is resolved")
        #endif
        return dependencies[key] as! Dependency
    }
}
