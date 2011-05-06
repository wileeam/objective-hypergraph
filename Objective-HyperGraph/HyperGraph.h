//
//  HyperGraph.h
//  Keiko
//
//  Created by Guillermo on 19/04/11.
//  Copyright 2011 Guillermo Rodríguez Cano. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HyperGraphProtocol.h"

@interface HyperGraph : NSObject <HyperGraphProtocol> {
    NSString *_uuid;
}

@end
