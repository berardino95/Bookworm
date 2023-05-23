//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Berardino Chiarello on 21/05/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    //Creating an instance of DataController and sent it to SwiftUI Environment
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
