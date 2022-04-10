//
//  ReflectionTests.swift
//
//  Copyright (c) 2022 Kelly Dun
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
import XCTest
@testable import Reflection

/// Unit tests.
final class ReflectionTests: XCTestCase {
    /// Validates that instantiating `ReflectionInstantiableSwiftClass` in the correct bundle succeeds.
    func testSwiftClassInBundleSuccess() throws {
        let bundle = Bundle(for: ReflectionInstantiableSwiftClass.self)
        let instance = Reflection.create("ReflectionInstantiableSwiftClass", bundle: bundle)
        XCTAssertNotNil(instance)
    }
    
    /// Validates that instantiating `ReflectionInstantiableSwiftClass` in the main bundle fails
    /// because `ReflectionInstantiableSwiftClass` belongs to `ReflectionTests`.
    func testSwiftClassInMainBundleFails() throws {
        let instance = Reflection.create("ReflectionInstantiableSwiftClass")
        XCTAssertNil(instance)
    }
    
    /// Validates that instantiating `SwiftClass` in the correct bundle, but does not conform to `ReflectionInstantiable`
    /// fails to create an instance.
    func testNonConformingSwiftClassInBundleFails() throws {
        let bundle = Bundle(for: SwiftClass.self)
        let instance = Reflection.create("SwiftClass", bundle: bundle)
        XCTAssertNil(instance)
    }
}
