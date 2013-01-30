//
//  NSData+DZ.h
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 23.04.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>



void *dmzNewBase64Decode(const char *inputBuffer,
                      size_t length,
                      size_t *outputLength);

char *dmzNewBase64Encode(const void *inputBuffer,
                      size_t length,
                      bool separateLines,
                      size_t *outputLength);


@interface NSData (DZ)

// Base 64 Encoding
+ (NSData *)dataFromBase64String:(NSString *)aString;
- (NSString *)base64EncodedString;

// AES
- (NSString *)decryptWithKey:(NSString *)key;
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

// Hashing
@property (nonatomic, readonly) NSString *SHA1;
@property (nonatomic, readonly) NSString *MD5;

@end