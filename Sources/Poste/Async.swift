public func async<T>(_ closure: @escaping () -> T?) -> OptionalPoste<T> {
    return OptionalPoste<T>(closure: closure)
}

public func async<T>(_ closure: @escaping () -> T) -> RequiredPoste<T> {
    return RequiredPoste<T>(closure: closure)
}

@discardableResult
public func async(_ closure: @escaping () -> Void) -> VoidPoste {
    return VoidPoste(closure: closure)
}

public func async<T>(_ closure: @escaping () throws -> T?) -> ThrowingOptionalPoste<T> {
    return ThrowingOptionalPoste(closure: closure)
}

public func async<T>(_ closure: @escaping () throws -> T) -> ThrowingRequiredPoste<T> {
    return ThrowingRequiredPoste(closure: closure)
}

@discardableResult
public func async(_ closure: @escaping () throws -> Void) -> ThrowingVoidPoste {
    return ThrowingVoidPoste(closure: closure)
}
