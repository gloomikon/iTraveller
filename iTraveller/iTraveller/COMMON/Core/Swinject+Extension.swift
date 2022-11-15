import Swinject

extension Container {
    func autoResolve<T>() -> T {
        resolve(T.self)!
    }
}

extension Resolver {
    func autoResolve<T>() -> T {
        resolve(T.self)!
    }
}
