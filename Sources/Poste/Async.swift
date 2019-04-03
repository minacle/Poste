import Dispatch

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> T) -> Poste<T> {
    return Poste<T>(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> Void) -> Poste<Void> {
    return Poste<Void>(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> T) -> ThrowingPoste<T> {
    return ThrowingPoste<T>(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> Void) -> ThrowingPoste<Void> {
    return ThrowingPoste<Void>(closure: closure, qos: qos, timeout: timeout)
}

public enum PosteLazy {
    case lazy
}

public func async<T>(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> T) -> LazyPoste<T, Poste<T>> {
    return LazyPoste(base: async(qos: qos, timeout: timeout, closure))
}
