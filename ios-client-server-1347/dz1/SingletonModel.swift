//
//  SingletonModel.swift
//  ios-client-server-1347
//
//  Created by Олег on 06.07.2021.
//

import Foundation

final class Session {
    private init() {}
    
    static let session = Session()
    
    var token: String = "для хранения токена в VK"
    var userId: Int = 0
    
}
