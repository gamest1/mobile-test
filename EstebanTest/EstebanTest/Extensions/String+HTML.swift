//
//  String+HTML.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-25.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import Foundation

extension String{
    //Basic removal of HTML tags. Enhance or refactor as needed:
    func removeSimpleHTMLTags() -> String {
        var resp = ""
        let a = self.split(separator: "<", maxSplits: Int.max, omittingEmptySubsequences: false)
        resp += a[0]
        for idx in a.indices {
            if idx > 0 {
                let b = a[idx].split(separator: ">", maxSplits: Int.max, omittingEmptySubsequences: false)
                if b.count == 2 {
                    resp += b[1]
                } else {
                    NSLog("Error when parsing HTML string")
                    return self
                }
            }
        }
        return resp
    }
}

