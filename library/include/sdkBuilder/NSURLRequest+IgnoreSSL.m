//
//  NSURLRequest+IgnoreSSL.m
//  Rest
//
//  Created by Star Systems Internation on 26/10/2016.
//  Copyright © 2016 Star Systems International. All rights reserved.
//

#import "NSURLRequest+IgnoreSSL.h"

@implementation NSURLRequest (IgnoreSSL)

//+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host
//{
//    // ignore certificate errors only for this domain
//    if ([host hasSuffix:@"10.1.1.105:35443"])
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}

+(BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host
{
    return YES;
}

@end
