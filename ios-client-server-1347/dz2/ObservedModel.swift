//
//  ObservedModel.swift
//  ios-client-server-1347
//
//  Created by Олег on 13.07.2021.
//

import Combine

final class AuthModel: ObservableObject {
    
    @Published var authorized = 0
    @Published var caption = "Client id:"
    
}
