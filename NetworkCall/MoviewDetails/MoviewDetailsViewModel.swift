//
//  MoviewDetailsViewModel.swift
//  NetworkCall
//
//  Created by Ravikanth Thummala on 8/3/23.
//

import Foundation
import Combine

class MoviewDetailsViewModel:ObservableObject {
 
    let movie:Movie
    @Published var data: (credits: [MovieCastMember], reviews: [MovieReview]) = ([], [])
        
    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchData() {
        let creditsPublisher = fetchCredits(for: movie).map(\.cast).replaceError(with: [])
        let reviewsPublisher = fetchReviews(for: movie).map(\.results).replaceError(with: [])
        
        Publishers.Zip(creditsPublisher, reviewsPublisher)
            .receive(on: DispatchQueue.main)
            .map { (credits: $0.0, reviews: $0.1) }
            .assign(to: &$data)
    }
    
}

