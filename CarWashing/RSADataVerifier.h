//
//  RSADataVerifier.h
//  SafepayService
//
//  Created by wenbi on 11-4-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RSADataVerifier : NSObject {
    NSString *_publicKey;
}

- (id)initWithPublicKey:(NSString *)publicKey;

- (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString withRSA2:(BOOL)rsa2;
@end
