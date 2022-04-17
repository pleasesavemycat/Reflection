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
        let bundle = Bundle(for: type(of: self))
        XCTAssertNotNil(bundle, "Bundle for 'ReflectionInstantiableSwiftClass' is nil")
        
        guard let bundleIdentifier = bundle.bundleIdentifier else {
            XCTFail("Bundle for 'ReflectionInstantiableSwiftClass' has no bundle identifier")
            return
        }
        
        let instance = Reflection.create("ReflectionInstantiableSwiftClass", bundle: bundle)
        XCTAssertNotNil(instance, "No instance created for 'ReflectionInstantiableSwiftClass' in bundle '\(bundleIdentifier)'")
    }
    
    /// Validates that instantiating `ReflectionInstantiableSwiftClass` in the main bundle fails
    /// because `ReflectionInstantiableSwiftClass` belongs to `ReflectionTests`.
    func testSwiftClassInMainBundleFails() throws {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            XCTFail("Bundle.main has no bundle identifier")
            return
        }
        
        let instance = Reflection.create("ReflectionInstantiableSwiftClass")
        XCTAssertNil(instance, "Unexpectedly created instance 'ReflectionInstantiableSwiftClass' in bundle  '\(bundleIdentifier)'")
    }
    
    /// Validates that instantiating `SwiftClass` in the correct bundle, but does not conform to `ReflectionInstantiable`
    /// fails to create an instance.
    func testNonConformingSwiftClassInBundleFails() throws {
        let bundle = Bundle(for: type(of: self))
        XCTAssertNotNil(bundle, "Bundle for 'SwiftClass' is nil")
        
        guard let bundleIdentifier = bundle.bundleIdentifier else {
            XCTFail("Bundle for 'SwiftClass' has no bundle identifier")
            return
        }
        
        let instance = Reflection.create("SwiftClass", bundle: bundle)
        XCTAssertNil(instance, "Unexpectedly created instance 'SwiftClass' in bundle  '\(bundleIdentifier)'")
    }
}

// MARK: - Test Classes

/// Swift test class conforming to `ReflectionInstantiable`
class ReflectionInstantiableSwiftClass: ReflectionInstantiable {
    required init() {
        // Nothing to do
    }
}

/// Swift test class that does not conform to `ReflectionInstantiable`
class SwiftClass {
    // Intentionally empty
}
