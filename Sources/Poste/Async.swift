import Dispatch

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> T?) -> OptionalPoste<T> {
    return OptionalPoste<T>(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> T) -> RequiredPoste<T> {
    return RequiredPoste<T>(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> Void) -> VoidPoste {
    return VoidPoste(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> T?) -> ThrowingOptionalPoste<T> {
    return ThrowingOptionalPoste(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> T) -> ThrowingRequiredPoste<T> {
    return ThrowingRequiredPoste(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> Void) -> ThrowingVoidPoste {
    return ThrowingVoidPoste(closure: closure, qos: qos, timeout: timeout)
}

public enum PosteLazy {
    case lazy
}

public func async<T>(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> T?) -> LazyOptionalPoste<T> {
    return LazyOptionalPoste<T>(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> T) -> LazyRequiredPoste<T> {
    return LazyRequiredPoste<T>(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> Void) -> LazyVoidPoste {
    return LazyVoidPoste(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> T?) -> LazyThrowingOptionalPoste<T> {
    return LazyThrowingOptionalPoste(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> T) -> LazyThrowingRequiredPoste<T> {
    return LazyThrowingRequiredPoste(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(_ lazy: PosteLazy, qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> Void) -> LazyThrowingVoidPoste {
    return LazyThrowingVoidPoste(closure: closure, qos: qos, timeout: timeout)
}
