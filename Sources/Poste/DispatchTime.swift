import Dispatch

extension DispatchTime {

    internal init?(dispatchTimeIntervalSinceNow dispatchTimeInterval: DispatchTimeInterval) {
        let intervalNanoseconds: UInt64
        switch dispatchTimeInterval {
        case .seconds(let interval):
            intervalNanoseconds = UInt64(interval) * 1_000_000_000
        case .milliseconds(let interval):
            intervalNanoseconds = UInt64(interval) * 1_000_000
        case .microseconds(let interval):
            intervalNanoseconds = UInt64(interval) * 1_000
        case .nanoseconds(let interval):
            intervalNanoseconds = UInt64(interval) * 1
        case .never:
            fallthrough
        @unknown default:  // for objective-c projects
            return nil
        }
        let uptimeNanoseconds = DispatchTime.now().uptimeNanoseconds
        self.init(uptimeNanoseconds: uptimeNanoseconds + intervalNanoseconds)
    }
}
