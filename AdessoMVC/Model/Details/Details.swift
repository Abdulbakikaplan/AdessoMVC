//
//  Details.swift
//  AdessoMVC
//
//  Created by Abdülbaki Kaplan on 1/9/20.
//  Copyright © 2020 Abdülbaki Kaplan. All rights reserved.
//

import Foundation

struct Details {

    let status : String?
    var articles : [DetailsModel]?
}

extension Details : Decodable {

    enum  DetailsCodingKeys : String, CodingKey {
        case status = "status"
        case articles = "articles"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DetailsCodingKeys.self)

        status = try? container.decode(String.self, forKey: .status)
        articles = try? container.decode([DetailsModel].self, forKey: .articles)
    }

}
