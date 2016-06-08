//
//  RepresentativeController.swift
//  Representative
//
//  Created by Chad Watts on 6/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static func serchRepsByState(state: String, completion: (representatives: [Representative]) -> Void) {
        
        let url = searchByURLByState(state)
        
        NetworkController.performRequestForURL(url) { (data) in
            
            guard let data = data,
            let dictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments))
            let representativeDictionaries = dictionary["results"] as? [[String:AnyObject]] else {
                
                print("Unable to serialize json")
                completion(representatives: [])
                return
            }
            
            let representatives = representativeDictionaries.flatMap({Representative(dictionary: $0)})
            completion(representatives: representatives)
            
        }
        
    }
    static let baseURLString = ""
    
    static func serchURLByState(state: String) -> NSURL {
        return NSURL(string: baseURLString + "/getAll_reps_byState.php?state=\(state)&output=json")!
    }
    
}
