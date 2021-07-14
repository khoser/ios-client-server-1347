//
//  ContetntView.swift
//  ios-client-server-1347
//
//  Created by Олег on 09.07.2021.
//

import SwiftUI
import UIKit
import Alamofire
import Combine

struct ContentView: View {
    
    @State var IdClient: String = ""
    @State var resultstring: String = ""
    @State var PhotoCount: String = "20"
    @State var PhotoOffset: String = "0"
    @State var SearchGr: String = ""
    
    @State private var isPresentedAuthView = false
    
    @ObservedObject var authModel = AuthModel()
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                VStack{
                    HStack{
                        Text("\(authModel.caption)")
                        TextField("Client_ID", text: $IdClient).padding().opacity(1 - Double(authModel.authorized))
                    }
                    Button(action: {
                        Session.session.client_id = IdClient
                        self.isPresentedAuthView.toggle()
                    }, label: {
                        Text("Open authorization dialog")
                    }).sheet(isPresented: self.$isPresentedAuthView, content: {
                        AuthView(Authorized: $authModel.authorized, Caption: $authModel.caption)
                    })
                    .opacity(1 - Double(authModel.authorized))
                    Divider()
                    
                    Button(action: {
                        let url = VKAPIService(Session.session.userId, Session.session.token).requestFriends()
                        //AF.request(url).responseJSON
                        AF.request(url).responseString { response in
                            guard let res = response.value else {return}
                            resultstring = res
                            print(res)
                        }
                    }, label: {
                        Text("Friends")
                    }).padding()
                    
                    HStack{
                        Button(action: {
                            let url = VKAPIService(Session.session.userId, Session.session.token).requestPhotos(count: Int(PhotoCount)!, offset: Int(PhotoOffset)!)
                            //AF.request(url).responseJSON
                            AF.request(url).responseString { response in
                                guard let res = response.value else {return}
                                resultstring = res
                                print(res)
                            }
                        }, label: {
                            Text("Photos:")
                        }).padding()
                        TextField("Count:", text: $PhotoCount).padding()
                        TextField("Offset:", text: $PhotoOffset).padding()
                    }
                    Button(action: {
                        let url = VKAPIService(Session.session.userId, Session.session.token).requestGroups()
                        //AF.request(url).responseJSON
                        AF.request(url).responseString { response in
                            guard let res = response.value else {return}
                            resultstring = res
                            print(res)
                        }
                    }, label: {
                        Text("Groups")
                    })
                    HStack{
                        TextField("Search string", text: $SearchGr).padding()
                        Button(action: {
                            let url = VKAPIService(Session.session.userId, Session.session.token).requestSearchGroups(SearchGr)
                            //AF.request(url).responseJSON
                            AF.request(url).responseString { response in
                                guard let res = response.value else {return}
                                resultstring = res
                                print(res)
                            }
                        }, label: {
                            Text("Search Groups")
                        }).padding()
                    }
                    //Divider()
                    
                    ScrollView(){
                        Text(resultstring).padding()
                    }
                    
                }.padding()
            }
            .navigationBarTitle("VK auth")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
