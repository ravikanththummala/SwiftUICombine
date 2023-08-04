//
//  MovieViewModel.swift
//  NetworkCall
//
//  Created by Ravikanth Thummala on 8/3/23.
//

import Foundation
import Combine

final class MovieViewModel:ObservableObject {
    
    @Published var  upcommingMovies:[Movie] =  []
    @Published var searchQuery:String = ""
    @Published private var searchResults:[Movie] =  []

    var movies:[Movie] {
        if searchQuery.isEmpty{
            return upcommingMovies
        }else {
            print(searchResults)
            return searchResults
        }
    }
    var cancelables = Set<AnyCancellable>()

    init(){
        $searchQuery
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .map{ searchQuery in
                searchMovies(for: searchQuery)
                    .replaceError(with: MovieResponse(results: []))
            }
            .switchToLatest()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .assign(to: &$searchResults)
    }
    
    func fetchInitialData() {
        fetchMovies()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: &$upcommingMovies)
    }
    
}
