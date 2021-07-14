//
//  VKAuthService.swift
//  ios-client-server-1347
//
//  Created by Олег on 09.07.2021.
//

import Foundation


class VKAuthService {
    var clientid: String
    
    init(_ client_id: String){
        clientid  = client_id
    }
    
    func request () -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: clientid),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68"),
            URLQueryItem(name: "revoke", value: "1")
        ]
        
        return URLRequest(url: urlComponents.url!)
        
    }
}

class VKAPIService {
    var user_id: Int
    var token: String
   
    init(_ user_id: Int, _ token: String){
        self.user_id  = user_id
        self.token = token
        
    }
    
    func requestFriends () -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: String(user_id)),
            URLQueryItem(name: "fields", value: "first_name,last_name"),
            URLQueryItem(name: "return_system", value: "0"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let ret = URLRequest(url: urlComponents.url!)
        print(ret)
        return ret
        
    }
    
    func requestPhotos (count:Int = 20, offset:Int = 0) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "owner_id", value: String(user_id)),
            URLQueryItem(name: "count", value: String(count)),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let ret = URLRequest(url: urlComponents.url!)
        print(ret)
        return ret
        
    }
    
    func requestGroups () -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: String(user_id)),
            URLQueryItem(name: "fields", value: "description"),
//            URLQueryItem(name: "count", value: String(count)),
//            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let ret = URLRequest(url: urlComponents.url!)
        print(ret)
        return ret
        
    }
    
    func requestSearchGroups (_ q: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "q", value: q),
//            URLQueryItem(name: "count", value: String(count)),
//            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let ret = URLRequest(url: urlComponents.url!)
        print(ret)
        return ret
        
    }
}
