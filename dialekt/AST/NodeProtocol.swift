//
//  NodeProtocol.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 25/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

protocol NodeProtocol {
    // Pass this node to the appropriate method on the given visitor.
    func accept(visitor: VisitorProtocol) -> Any
}
