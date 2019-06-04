//
//  SearchView.swift
//  UISwift_OMDb_Client
//
//  Created by Robin Douglas on 04/06/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State var searchFieldText: String = ""

    var body: some View {
        VStack {
            TextField($searchFieldText, placeholder: Text("Search"))
                .padding()
            Button(action: {
                print(self.searchFieldText)
            }) {
                Text("Search")
                    .font(.headline)
            }
                .padding()
            Spacer()
        }
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
#endif