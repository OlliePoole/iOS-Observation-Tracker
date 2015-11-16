//
//  OTXMLParser.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 16/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

class OTXMLParser: NSObject {
    
    private var xmlParser : NSXMLParser!
    private var rootElement : OTXMLElement!
    private var currentElement : OTXMLElement!

    func parseXML(xmlData : NSData) -> OTXMLElement? {
        xmlParser = NSXMLParser(data: xmlData)
        xmlParser.delegate = self
        
        return xmlParser.parse() ? rootElement : nil
    }
}

extension OTXMLParser : NSXMLParserDelegate {
    
    func parserDidStartDocument(parser: NSXMLParser) {
        rootElement = nil
        currentElement = nil
    }
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if rootElement == nil {
            // Initalise the root element
            rootElement = OTXMLElement()
            currentElement = rootElement
        }
        else {
            // Add element to sub elements of existing element
            let element = OTXMLElement()
            element.parent = currentElement
            
            if currentElement.subElements == nil {
                currentElement.subElements = Array()
            }
            
            currentElement.subElements.append(element)
            currentElement = element
        }
        
        currentElement.name = elementName
        currentElement.attributes = attributeDict
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if currentElement.text == nil {
            currentElement.text = string
        }
        else {
            currentElement.text = currentElement.text + string
        }
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement = currentElement.parent
    }
    
    
    func parserDidEndDocument(parser: NSXMLParser) {
        currentElement = nil
    }
}
