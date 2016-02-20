//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Erik Nascimento on 2/14/16.
//  Copyright © 2016 2EG. All rights reserved.
//

import Foundation

class Videos {
    
    var vRank = 0
    // Data Encapsulation
    
    private var _vName:String
    private var _vRights:String
    private var _vPrice:String
    private var _vImageUrl:String
    private var _vArtist:String
    private var _vVideoUrl:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinktToiTunes:String
    private var _vReleaseDte:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    //Make a getter
    
    var vName: String{
        return _vName
    }
    
    var vRights: String{
        return _vRights
    }
    
    var vPrice: String{
        return _vPrice
    }
    
    var vImageUrl: String{
        return _vImageUrl
    }
    
    var vArtist: String{
        return _vArtist
    }

    var vVideoUrl: String{
        return _vVideoUrl
    }
    
    var vImid: String{
        return _vImid
    }
    
    var vGenre: String{
        return _vGenre
    }
    
    var vLinktToiTunes: String{
        return _vLinktToiTunes
    }
    
    var vReleaseDte: String{
        return _vReleaseDte
    }

    
    init(data:JSONDictionary){
        
        if let name = data["im:name"] as?JSONDictionary, vName = name["label"] as? String{
            self._vName = vName
        }else{
            _vName = ""
        }
        
        if let rights = data["rights"] as?JSONDictionary, vRights = rights["label"] as? String{
            self._vRights = vRights
        }else{
            _vRights = ""
        }
        
        if let price = data["im:price"] as?JSONDictionary, vPrice = price["label"] as? String{
            self._vPrice = vPrice
        }else{
            _vPrice = ""
        }
        
        if let img = data["im:image"] as? JSONArray, image = img[2] as? JSONDictionary, immage = image["label"] as? String{
            self._vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }else{
            _vImageUrl = ""
        }
        
        if let artist = data["im:artist"] as?JSONDictionary, vArtist = artist["label"] as? String{
            self._vArtist = vArtist
        }else{
            _vArtist = ""
        }
        
        if let video = data["link"] as? JSONArray, vUrl = video[1] as? JSONDictionary, vHref = vUrl["attributes"] as? JSONDictionary, vVideoUrl = vHref["href"] as? String{
            self._vVideoUrl = vVideoUrl
        }else{
            _vVideoUrl = ""
        }
        
        if let imid = data["id"] as? JSONDictionary, vImid = imid["attributes"] as? JSONDictionary, vimid = vImid["im:id"] as? String{
            self._vImid = vimid
        }else{
            _vImid = ""
        }
        
        if let genre = data["category"] as? JSONDictionary, cat = genre["attributes"] as? JSONDictionary, category = cat["term"] as? String{
            self._vGenre = category
        }else{
            _vGenre = ""
        }
        
        if let linkiTunes = data["id"] as? JSONDictionary,  iTunes = linkiTunes["label"] as? String{
            self._vLinktToiTunes = iTunes
        }else{
            _vLinktToiTunes = ""
        }
        
        if let release = data["im:releaseDate"] as? JSONDictionary, rel2 = release["attributes"] as? JSONDictionary,  date = rel2["label"] as? String{
            self._vReleaseDte = date
        }else{
            _vReleaseDte = ""
        }
        
    }
    
}