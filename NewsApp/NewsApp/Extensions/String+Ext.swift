//
//  String+Ext.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 05.02.23.
//

import Foundation

///Extension for kirilic symbol in url
extension String{
    var encodeUrl : String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    var decodeUrl : String {
        return self.removingPercentEncoding!
    }
}
