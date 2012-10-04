//
//  ASINSXMLParserCompat.h
//
//  Created by Rahul on 26/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


#if (!TARGET_OS_IPHONE  && __MAC_OS_X_VERSION_MAX_ALLOWED < __MAC_10_6) || (TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_4_0)
@protocol NSXMLParserDelegate

@optional
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

@end
#endif




