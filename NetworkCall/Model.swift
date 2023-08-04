//
//  Model.swift
//  NetworkCall
//
//  Created by Ravikanth Thummala on 8/3/23.
//

import Foundation

let jsonDecoder : JSONDecoder = {
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()


//MARK: Movies

struct Movie: Decodable, Equatable,Identifiable {
    let id:Int
    let title:String
    let overview:String
    let posterPath:String?
    var posterURL: URL? {
          posterPath.map { URL(string: "https://image.tmdb.org/t/p/w400/\($0)")! }
    }
}
struct MovieResponse: Decodable {
    let results:[Movie]
}


struct MovieCastMember: Decodable,Equatable,Identifiable {
    let id:Int
    let name:String
    let character:String

}

struct MovieCreditsResponse: Decodable {
    let cast:[MovieCastMember]
}

//MARK: - Reviews

struct MovieReview: Identifiable, Equatable, Decodable {
    let id: String
    let author: String
    let content: String
}

struct MovieReviewsResponse: Decodable {
    let results: [MovieReview]
}


