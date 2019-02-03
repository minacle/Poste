import Foundation

internal let globalQueue =
    DispatchQueue(
        label: "moe.minacle.lib.poste",
        attributes: .concurrent)

private var randomNumberGenerator = SystemRandomNumberGenerator()

public protocol Poste {}

public final class OptionalPoste<T>: Poste {

    internal let queue =
        DispatchQueue(
            label: "moe.minacle.lib.poste.\(randomNumberGenerator.next())?",
            target: globalQueue)

    internal var result: T?

    internal required init(closure: @escaping () -> T?) {
        self.queue.async {
            self.result = closure()
        }
    }
}

public final class RequiredPoste<T>: Poste {

    internal let queue =
        DispatchQueue(
            label: "moe.minacle.lib.poste.\(randomNumberGenerator.next())!",
            target: globalQueue)

    internal var result: T!

    internal required init(closure: @escaping () -> T) {
        self.queue.async {
            self.result = closure()
        }
    }
}

public final class VoidPoste: Poste {

    internal let queue =
        DispatchQueue(
            label: "moe.minacle.lib.poste.\(randomNumberGenerator.next())",
            target: globalQueue)

    internal required init(closure: @escaping () -> Void) {
        self.queue.async {
            closure()
        }
    }
}
