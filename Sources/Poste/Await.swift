import Dispatch

public func await<T>(_ poste: NullablePoste<T>, timeout: DispatchTimeInterval = .never, resume: Bool = true) -> T? {
    if resume {
        if case .suspended = poste.state {
            poste.resume()
        }
    }
    if let time = DispatchTime(dispatchTimeIntervalSinceNow: timeout) {
        _ = poste.group.wait(timeout: time)
    }
    else {
        poste.group.wait()
    }
    return poste.result
}

public func await<T>(_ poste: NonnullPoste<T>, timeout: DispatchTimeInterval = .never, resume: Bool = true) -> T {
    if resume {
        if case .suspended = poste.state {
            poste.resume()
        }
    }
    if let time = DispatchTime(dispatchTimeIntervalSinceNow: timeout) {
        _ = poste.group.wait(timeout: time)
    }
    else {
        poste.group.wait()
    }
    return poste.result
}

public func await(_ poste: VoidPoste, timeout: DispatchTimeInterval = .never, resume: Bool = true) {
    if resume {
        if case .suspended = poste.state {
            poste.resume()
        }
    }
    if let time = DispatchTime(dispatchTimeIntervalSinceNow: timeout) {
        _ = poste.group.wait(timeout: time)
    }
    else {
        poste.group.wait()
    }
    return
}

public func await<T>(_ poste: ThrowingNullablePoste<T>, timeout: DispatchTimeInterval = .never, resume: Bool = true) throws -> T? {
    if resume {
        if case .suspended = poste.state {
            poste.resume()
        }
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

public func await<T>(_ poste: ThrowingNonnullPoste<T>, timeout: DispatchTimeInterval = .never, resume: Bool = true) throws -> T {
    if resume {
        if case .suspended = poste.state {
            poste.resume()
        }
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

public func await(_ poste: ThrowingVoidPoste, timeout: DispatchTimeInterval = .never, resume: Bool = true) throws {
    if resume {
        if case .suspended = poste.state {
            poste.resume()
        }
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
