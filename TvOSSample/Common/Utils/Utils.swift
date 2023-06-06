//
//  Utils.swift
//  TvOSSample
//
//  Created by Luis Enrique Diaz Ramirez on 06/06/23.
//

import Foundation
import AVKit

struct Utils{
    func makeExternalMetadata() -> [AVMetadataItem]{
        var metadata = [AVMetadataItem]()
        
        //build title item
        let titleItem = makeMetadataItem(.commonIdentifierTitle, value: "Improve your Debugging Skills")
        metadata.append(titleItem)
        
        //Buid Artwork Item
        if let image = UIImage(named: "debugging"), let pngData = image.pngData(){
            let artworkItem = makeMetadataItem(.commonIdentifierArtwork, value: pngData)
            metadata.append(artworkItem)
        }
        
        //Build description item
        let descItem = makeMetadataItem(.commonIdentifierDescription, value: """
    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
"""
        )
        metadata.append(descItem)
        
        //build genre item
        let genreItem = makeMetadataItem(.quickTimeMetadataGenre, value: "Education")
        metadata.append(genreItem)
        
        return metadata
    }
    
    private func makeMetadataItem(_ identifier: AVMetadataIdentifier, value: Any) -> AVMetadataItem{
        let item = AVMutableMetadataItem()
        item.identifier = identifier
        item.value = value as? NSCopying & NSObjectProtocol
        item.extendedLanguageTag = "und"
        return item.copy() as! AVMetadataItem
    }
}
