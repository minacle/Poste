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

public func await<T>(_ poste: ThrowingOptionalPoste<T>) throws -> T? {
    var result: T?
    var error: Error?
    poste.queue.sync {
        result = poste.result
        error = poste.error
    }
    guard error == nil else {
        throw error!
    }
    return result
}

public func await<T>(_ poste: ThrowingRequiredPoste<T>) throws -> T {
    var result: T!
    var error: Error?
    poste.queue.sync {
        result = poste.result
        error = poste.error
    }
    guard error == nil else {
        throw error!
    }
    return result
}

public func await(_ poste: ThrowingVoidPoste) throws {
    var error: Error?
    poste.queue.sync {
        error = poste.error
    }
    guard error == nil else {
        throw error!
    }
    return
}
