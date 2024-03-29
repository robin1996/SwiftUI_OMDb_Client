//
//  OMDbItem.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import SwiftUI
import Combine

final class MovieDataBO: BindableObject {
    init(search: String) {
        searchString = search
        performSearch()
    }

    deinit {
        dataTask?.cancel()
    }

    let didChange = PassthroughSubject<MovieDataBO, Never>()
    private var dataTask: URLSessionDataTask?
    var searchString: String {
        didSet {
            performSearch()
            didChange.send(self)
        }
    }
    var movies: [OMDbItem] = [] {
        didSet {
            didChange.send(self)
        }
    }

    func performSearch() {
        dataTask = APIService.searchOMDb(for: searchString) { [weak self] (result) in
            switch result {
            case .failure: break
            case .success(let search):
                self?.movies = search.search ?? []
            }
        }
    }
}

struct OMDbSearch: Codable {
    let search: [OMDbItem]?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct OMDbItem: Codable, Identifiable {
    let id: String
    let title: String?
    let year: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case id     = "imdbID"
        case title  = "Title"
        case year   = "Year"
        case poster = "Poster"
    }
}
