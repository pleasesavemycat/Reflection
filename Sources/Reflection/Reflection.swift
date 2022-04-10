//
//  Reflection.swift
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
import Foundation

/// Provides reflection-based instantiation of classes conforming to `ReflectionInstantiable`.
public class Reflection {
    /// Attempts to instantiate the specified class.
    /// - Parameter className: Unqualified name of the class.
    /// - Parameter bundle: Bundle to search for the `className`. The default value is `.main`.
    /// - Returns: The class instance if it exists; otherwise `nil`.
    public static func create(_ className: String, bundle: Bundle = .main) -> ReflectionInstantiable? {
        // Objective-C class found that conforms to protocol `T`.
        if let klass = NSClassFromString(className) as? ReflectionInstantiable.Type {
            return klass.init()
        }
        
        // Require the bundle identifier to exist before attempting
        // to try instantiation of a Swift class.
        guard let bundleIdentifier = bundle.bundleIdentifier else {
            return nil
        }
        
        // Swift class names are namespaced with the format: "namespace.class_name"
        // Attempt to instantiate the namespaced class conforming to protocol `T`.
        let swiftClassName = "\(bundleIdentifier).\(className)"
        guard let swiftKlass = NSClassFromString(swiftClassName) as? ReflectionInstantiable.Type else {
            return nil
        }
        
        return swiftKlass.init()
    }
}
