/*
 * Vertex.m
 *
 * Copyright (C) 2011, Guillermo Rodriguez-Cano
 * All rights reserved.
 *
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 *
 * Contacting the author:
 *   Guillermo Rodriguez-Cano:  wileeam@acm.org
 *
 * @version $Id$
 *
 */


#import "Vertex.h"


@implementation Vertex

#pragma mark - Properties synthesization
@synthesize name=_name;
@synthesize uuid=_uuid;

#pragma mark - Initialisation and memory management

- (id)init
{

    // Parent initialisation's check and adjacent matrix's population
	if ((self = [super init]) != nil) {
        _uuid = [NSString stringWithUUID];
    }
    
    // Return myself!
    return self;
    
} // init()

+ (Vertex *)vertex
{
    
    return [[Vertex alloc] init];

} // vertex()

#pragma mark - System overriden implementation

- (NSString *)description
{
    
    NSMutableString *string = [NSMutableString string];
    
    // Print UUID's vertex
    [string appendString:[NSString stringWithFormat:@"Vertex [%@] (%@)\n", _name, self.uuid ]];
    
    return string;
    
} // description()


#pragma mark - NSCopying protocol implementation

- (id)copyWithZone:(NSZone *)zone
{
    Vertex *objectCopy = [[Vertex allocWithZone:zone] init];
    // Copy over all instance variables from self to objectCopy.
    // Use deep copies for all strong pointers, shallow copies for weak.
    return objectCopy;
    
} // copyWithZone()


#pragma mark - Vertex protocol implementation

- (BOOL)isEqual:(id)object
{
    
    if (object == nil) {
        return FALSE;
    }
    
    if (![object isKindOfClass:[Vertex class]]) {
        return FALSE;
    }    
    
    Vertex *other = (Vertex *) object;
    
    return self.uuid == other.uuid;
    
} // isEqual()

@end
