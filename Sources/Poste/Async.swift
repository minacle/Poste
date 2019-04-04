import Dispatch

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> T) -> Poste<T> {
    return Poste(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> Void) -> Poste<Void> {
    return Poste(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> T) -> ThrowingPoste<T> {
    return ThrowingPoste(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> Void) -> ThrowingPoste<Void> {
    return ThrowingPoste(closure: closure, qos: qos, timeout: timeout)
}

public enum PosteLazy {
    case lazy
}

public func async<T>(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> T) -> LazyPoste<T> {
    return LazyPoste(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> Void) -> LazyPoste<Void> {
    return LazyPoste(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> T) -> LazyThrowingPoste<T> {
    return LazyThrowingPoste(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> Void) -> LazyThrowingPoste<Void> {
    return LazyThrowingPoste(closure: closure, qos: qos, timeout: timeout)
}
