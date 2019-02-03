import Foundation

internal let globalQueue =
    DispatchQueue(
        label: "moe.minacle.lib.poste",
        attributes: .concurrent)

private var newPosteQueue: DispatchQueue {
    return DispatchQueue(
        label: "moe.minacle.lib.poste.\(randomNumberGenerator.next())",
        target: globalQueue)
}

private var randomNumberGenerator = SystemRandomNumberGenerator()

public protocol Poste {}

public final class OptionalPoste<T>: Poste {

    internal let queue = newPosteQueue

    internal var result: T?

    internal required init(closure: @escaping () -> T?) {
        self.queue.async {
            self.result = closure()
        }
    }
}

public final class RequiredPoste<T>: Poste {

    internal let queue = newPosteQueue

    internal var result: T!

    internal required init(closure: @escaping () -> T) {
        self.queue.async {
            self.result = closure()
        }
    }
}

public final class VoidPoste: Poste {

    internal let queue = newPosteQueue

    internal required init(closure: @escaping () -> Void) {
        self.queue.async {
            closure()
        }
    }
}

public final class ThrowingOptionalPoste<T>: Poste {

    internal let queue = newPosteQueue

    internal var result: T?
    internal var error: Error?

    internal required init(closure: @escaping () throws -> T?) {
        self.queue.async {
            do {
                self.result = try closure()
            }
            catch {
                self.error = error
            }
        }
    }
}

public final class ThrowingRequiredPoste<T>: Poste {

    internal let queue = newPosteQueue

    internal var result: T!
    internal var error: Error?

    internal required init(closure: @escaping () throws -> T) {
        self.queue.async {
            do {
                self.result = try closure()
            }
            catch {
                self.error = error
            }
        }
    }
}

public final class ThrowingVoidPoste: Poste {

    internal let queue = newPosteQueue

    internal var error: Error?

    internal required init(closure: @escaping () throws -> Void) {
        self.queue.async {
            do {
                try closure()
            }
            catch {
                self.error = error
            }
        }
    }
}
