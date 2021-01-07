//
//  MCOIMAPPart.m
//  mailcore2
//
//  Created by DINH Viêt Hoà on 3/23/13.
//  Copyright (c) 2013 MailCore. All rights reserved.
//

#import "MCOIMAPPart.h"

#include "MCIMAP.h"

#import "MCOUtils.h"

@implementation MCOIMAPPart

#define nativeType mailcore::IMAPPart

+ (void) load
{
    MCORegisterClass(self, &typeid(nativeType));
}

+ (NSObject *) mco_objectWithMCObject:(mailcore::Object *)object
{
    mailcore::IMAPPart * part = (mailcore::IMAPPart *) object;
    return [[[self alloc] initWithMCPart:part] autorelease];
}

MCO_SYNTHESIZE_NSCODING

MCO_OBJC_SYNTHESIZE_STRING(setPartID, partID)
MCO_OBJC_SYNTHESIZE_SCALAR(unsigned int, unsigned int, setSize, size)
MCO_OBJC_SYNTHESIZE_SCALAR(MCOEncoding, mailcore::Encoding, setEncoding, encoding)

- (unsigned int) decodedSize
{
    return MCO_NATIVE_INSTANCE->decodedSize();
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [self initWithMCPart:new nativeType()]) {
        [self updateWithDict:dict];
    }
    return self;
}

- (void)updateWithDict:(NSDictionary *)dict {
    [super updateWithDict:dict];
    if (dict[@"partID"]) {
        self.partID = dict[@"partID"];
    }
    self.encoding = (MCOEncoding)[dict[@"encoding"] integerValue];
    self.size = [dict[@"size"] unsignedIntValue];
}

- (NSDictionary *)toDict {
    NSMutableDictionary *ret = [[NSMutableDictionary alloc] init];
    [ret addEntriesFromDictionary:[super toDict]];
    if (self.partID) {
        ret[@"partID"] = self.partID;
    }
    ret[@"encoding"] = @(self.encoding);
    ret[@"size"] = @(self.size);
    return ret;
}

@end
