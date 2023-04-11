//
//  ContentView.swift
//  Ds Life Planner
//
//  Created by BoiseITGuru on 4/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ResponsiveView { props in
            Home(props: props)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
