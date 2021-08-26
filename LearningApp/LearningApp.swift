//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by stella on 2021/8/26.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(ContentModel())
        }
    }
}
