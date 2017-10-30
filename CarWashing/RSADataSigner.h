//
//  RSADataSigner.h
//  SafepayService
//
//  Created by wenbi on 11-4-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RSADataSigner : NSObject {
    NSString * _privateKey;
}

- (id)initWithPrivateKey:(NSString *)privateKey;

- (NSString *)signString:(NSString *)string withRSA2:(BOOL)rsa2;


@end
