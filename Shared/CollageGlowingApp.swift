//
//  CollageGlowingApp.swift
//  Shared
//
//  Created by Sona Sargsyan on 07.06.22.
//

import SwiftUI

@main
struct CollageGlowingApp: App {
    var body: some Scene {
        WindowGroup {
            ListView(viewModel: ListViewModelImpl().toAnyViewModel())
        }
    }
}
