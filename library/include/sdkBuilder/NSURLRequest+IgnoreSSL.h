//
//  NSURLRequest+IgnoreSSL.h
//  Rest
//
//  Created by Star Systems Internation on 26/10/2016.
//  Copyright © 2016 Star Systems International. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (ignoreSSL)

// http://stackoverflow.com/questions/12347410/iphone-secure-restfull-server-the-certificate-for-this-server-is-invalid

//+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

+(BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

@end
