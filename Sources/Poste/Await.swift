import Dispatch

public func await<T>(timeout: DispatchTimeInterval = .never, _ poste: NullablePoste<T>) -> T? {
    if !poste.isFired {
        poste.fire()
    }
    if let time = DispatchTime(dispatchTimeIntervalSinceNow: timeout) {
        _ = poste.group.wait(timeout: time)
    }
    else {
        poste.group.wait()
    }
    return poste.result
}

public func await<T>(timeout: DispatchTimeInterval = .never, _ poste: NonnullPoste<T>) -> T {
    if !poste.isFired {
        poste.fire()
    }
    if let time = DispatchTime(dispatchTimeIntervalSinceNow: timeout) {
        _ = poste.group.wait(timeout: time)
    }
    else {
        poste.group.wait()
    }
    return poste.result
}

public func await(timeout: DispatchTimeInterval = .never, _ poste: VoidPoste) {
    if !poste.isFired {
        poste.fire()
    }
    if let time = DispatchTime(dispatchTimeIntervalSinceNow: timeout) {
        _ = poste.group.wait(timeout: time)
    }
    else {
        poste.group.wait()
    }
    return
}

public func await<T>(timeout: DispatchTimeInterval = .never, _ poste: ThrowingNullablePoste<T>) throws -> T? {
    if !poste.isFired {
        poste.fire()
    }
    if let time = DispatchTime(dispatchTimeIntervalSinceNow: timeout) {
        _ = poste.group.wait(timeout: time)
    }
    else {
        poste.group.wait()
    }
    guard poste.error == nil else {
        throw poste.error!
    }
    return poste.result
}

public func await<T>(timeout: DispatchTimeInterval = .never, _ poste: ThrowingNonnullPoste<T>) throws -> T {
    if !poste.isFired {
        poste.fire()
    }
    if let time = DispatchTime(dispatchTimeIntervalSinceNow: timeout) {
        _ = poste.group.wait(timeout: time)
    }
    else {
        poste.group.wait()
    }
    guard poste.error == nil else {
        throw poste.error!
    }
    return poste.result
}

public func await(timeout: DispatchTimeInterval = .never, _ poste: ThrowingVoidPoste) throws {
    if !poste.isFired {
        poste.fire()
    }
    if let time = DispatchTime(dispatchTimeIntervalSinceNow: timeout) {
        _ = poste.group.wait(timeout: time)
    }
    else {
        poste.group.wait()
    }
    guard poste.error == nil else {
        throw poste.error!
    }
    return
}
