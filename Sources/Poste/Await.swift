public func await<T>(_ poste: OptionalPoste<T>) -> T? {
    var result: T?
    poste.queue.sync {
        result = poste.result
    }
    return result
}

public func await<T>(_ poste: RequiredPoste<T>) -> T {
    var result: T!
    poste.queue.sync {
        result = poste.result
    }
    return result
}

public func await(_ poste: VoidPoste) {
    poste.queue.sync {}
    return
}
