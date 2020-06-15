import Dispatch
import XCTest
@testable import Poste

final class PosteTests: XCTestCase {

    func testRequired() {
        let count = 8
        for _ in 0 ..< count {
            let number = Int.random(in: .min ... .max)
            let integer = async {
                () -> Int in
                sleep(1)
                return number
            }
            XCTAssertEqual(await(integer), number)
        }
    }

    func testRequiredAsync() {
        let count = 32 * (.bitWidth / 32) - 1
        let queue =
            DispatchQueue(
                label: "moe.minacle.lib.poste.test",
                attributes: .concurrent)
        let dsema = DispatchSemaphore(value: 0)
        var src = [Int]()
        var dest = [Int](repeating: .max, count: count)
        for _ in 0 ..< count {
            src.append(.random(in: .min ..< .max))
        }
        for index in 0 ..< count {
            let number = src[index]
            queue.async {
                let integer = async {
                    () -> Int in
                    sleep(1)
                    return number
                }
                dest[index] = await(integer)
                dsema.signal()
            }
        }
        for _ in 0 ..< count {
            dsema.wait()
        }
        for index in 0 ..< count {
            XCTAssertEqual(src[index], dest[index])
        }
    }

    func testOptional() {
        let count = 8
        for _ in 0 ..< count {
            let number = Int.random(in: 0 ... 1)
            let integerOrNil = async {
                () -> Int? in
                sleep(1)
                return number > 0 ? 1 : nil
            }
            let result = await(integerOrNil)
            if number == 0 {
                XCTAssertNil(result)
            }
            else {
                XCTAssertEqual(result, number)
            }
        }
    }

    func testVoid() {
        let count = 8
        var number = 0
        for _ in 0 ..< count {
            let poste = async {
                sleep(1)
                number += 1
            }
            await(poste)
        }
        XCTAssertEqual(number, count)
    }

    func testDone() {
        let count = 32 * (.bitWidth / 32) - 1
        let queue =
            DispatchQueue(
                label: "moe.minacle.lib.poste.test")
        let dsema = DispatchSemaphore(value: 0)
        var number = 0
        for _ in 0 ..< count {
            async {
                sleep(1)
            }
            .done {
                queue.sync {
                    number += 1
                }
                dsema.signal()
            }
            .cancelled {
                XCTFail()
                dsema.signal()
            }
        }
        let wallTime = DispatchWallTime.now() + Double(count) + 1
        for _ in 0 ..< count {
            _ = dsema.wait(wallTimeout: wallTime)
        }
        XCTAssertEqual(count, number)
    }

    func testCancelled() {
        let count = 32 * (.bitWidth / 32) - 1
        let queue =
            DispatchQueue(
                label: "moe.minacle.lib.poste.test")
        let dsema = DispatchSemaphore(value: 0)
        var number = 0
        for _ in 0 ..< count {
            async(timeout: .seconds(1)) {
                sleep(10)
            }
            .done {
                XCTFail()
                dsema.signal()
            }
            .cancelled {
                queue.sync {
                    number += 1
                }
                dsema.signal()
            }
        }
        let wallTime = DispatchWallTime.now() + Double(count) + 1
        for _ in 0 ..< count {
            _ = dsema.wait(wallTimeout: wallTime)
        }
        XCTAssertEqual(count, number)
    }
}
