//
//  Publisher+EX.swift
//  CollageGlowing (iOS)
//
//  Created by Sona Sargsyan on 14.06.22.
//

import Foundation
import Combine

public extension Publisher where Failure == Never {
    func assignWeakly<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on object: Root) -> AnyCancellable {
        sink { [weak object] in
            object?[keyPath: keyPath] = $0
        }
    }
}
