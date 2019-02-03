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
