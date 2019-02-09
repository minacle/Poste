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

    func testThenElse() {
        let numbers: [TimeInterval] = [0, 1, 2, 3, 2, 1, 0, 3]
        var results = [Bool?](repeating: nil, count: numbers.endIndex)
        let count = numbers.endIndex
        for index in 0 ..< count {
            let poste = async(timeout: .milliseconds(1500)) {
                Thread.sleep(forTimeInterval: numbers[index])
            }
            poste.then(async(.lazy) {
                results[index] = true
            })
            poste.else(async(.lazy) {
                results[index] = false
            })
        }
        Thread.sleep(forTimeInterval: numbers.max()! * 2)
        XCTAssertEqual(results, [true, true, false, false, false, true, true, false] as [Bool?])
    }

    static var allTests = [
        ("testRequired", testRequired),
        ("testRequiredAsync", testRequiredAsync),
        ("testOptional", testOptional),
        ("testVoid", testVoid),
        ("testThenElse", testThenElse),
    ]
}
