//
//  SourcesModel.swift
//  AdessoMVC
//
//  Created by Abdülbaki Kaplan on 1/9/20.
//  Copyright © 2020 Abdülbaki Kaplan. All rights reserved.
//

import Foundation

struct SourcesModel: Decodable {

    let id: String?
    let name: String?
    let description: String?
    let url: URL?
    let category: String?
    let language: String?
    let country:String?

}
