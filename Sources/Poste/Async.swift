import Dispatch

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> T?) -> NullablePoste<T> {
    return .init(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> T) -> NonnullPoste<T> {
    return .init(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () -> Void) -> VoidPoste {
    return .init(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> T?) -> ThrowingNullablePoste<T> {
    return .init(closure: closure, qos: qos, timeout: timeout)
}

public func async<T>(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> T) -> ThrowingNonnullPoste<T> {
    return .init(closure: closure, qos: qos, timeout: timeout)
}

@discardableResult
public func async(qos: DispatchQoS = .default, timeout: DispatchTimeInterval = .never, _ closure: @escaping () throws -> Void) -> ThrowingVoidPoste {
    return .init(closure: closure, qos: qos, timeout: timeout)
}
