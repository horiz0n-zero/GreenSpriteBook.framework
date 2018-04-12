//
//  Map2D.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 05/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

/// A structure used by Map2D
public struct Map2DHeader<G> {
    var magic: UInt64
    var size: CGSize
    var widthSize: Int
    var rawSize: Int
    
    init(size: CGSize) {
        self.magic = ((UInt64)(0b0110000011100001111010101))
        self.size = size
        self.widthSize = MemoryLayout<G>.size * Int(self.size.width)
        self.rawSize = self.widthSize * Int(self.size.height)
    }
}

/// A structure that encapsulate, can read or write to file 2D array of a `generic data type`.
public struct Map2D<G> {
    
    public var array: [[G]]
    public var header: Map2DHeader<G>
    
    /// init a new map with a default value
    public init(size: CGSize, fillWith defaultValue: G) {
        self.array = Array(repeating: Array(repeating: defaultValue, count: Int(size.width)), count: Int(size.height))
        self.header = Map2DHeader<G>(size: size)
    }
    
    /// save this map to a file
    public mutating func write(at path: String) {
        if FileManager.default.fileExists(atPath: path) == false {
            FileManager.default.createFile(atPath: path, contents: nil, attributes: [:])
        }
        guard let file = FileHandle(forWritingAtPath: path) else {
            fatalError(path)
        }
        
        file.truncateFile(atOffset: 0)
        let headerData = Data(bytesNoCopy: &self.header, count: MemoryLayout<Map2DHeader<G>>.size, deallocator: .none)
        
        file.write(headerData)
        for var width in self.array {
            let data = Data(bytesNoCopy: &width, count: self.header.widthSize, deallocator: .none)
            
            file.write(data)
        }
        file.closeFile()
    }
    
    /*
    /// write the file in background
    /// - parameter queue: specify the queue or use the default main queue.
    public mutating func writeInBackground(at path: String, queue: DispatchQueue = DispatchQueue.main) {
        queue.async(group: nil, qos: .background) {
            
        }
    }
     */
    
    /// load a map from a file
    public init(readFrom path: String, defaultValue: G) {
        self.array = [[G]]()
        self.header = Map2DHeader<G>(size: CGSize.zero)
        let fd = open(path, O_RDONLY)
        
        if fd <= 0 {
            fatalError(path)
        }
        if read(fd, &self.header, MemoryLayout<Map2DHeader<G>>.size) != MemoryLayout<Map2DHeader<G>>.size ||
            self.header.magic != ((UInt64)(0b0110000011100001111010101)) {
            fatalError("bad file")
        }
        for _ in 0...Int(self.header.size.height) {
            var data = Array(repeating: defaultValue, count: Int(self.header.size.width))
            
            if read(fd, &data, self.header.widthSize) != self.header.widthSize {
                fatalError("bad file")
            }
            self.array.append(data)
        }
    }
    
}






