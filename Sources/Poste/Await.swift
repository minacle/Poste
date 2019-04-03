import Dispatch

public func await<T>(timeout: DispatchTimeInterval = .never, _ poste: Poste<T>) -> T {
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

public func await<T>(timeout: DispatchTimeInterval = .never, _ poste: ThrowingPoste<T>) throws -> T {
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
