/*
 * HyperEdge.m
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


#import "HyperEdge.h"


@implementation HyperEdge

#pragma mark - Properties synthesization
@synthesize name=_name;

#pragma mark - Initialisation and memory management

- (id)init
{
    
    // Parent initialisation's check and adjacent matrix's population
	if ((self = [super init]) != nil) {
        _uuid = [NSString stringWithUUID];
        
        _vertices = [NSMutableSet set];
    }
    
    return self;
    
} // init()

- (id)initWithVertex:(Vertex *)vertex
{
    
    if ([self init] != nil) {
        [self addVertex:vertex];
    }
    
    return self;
    
} // initWithVertex()

- (id)initWithVertices:(NSArray *)vertices
{
    
    if ([self init] != nil) {
        [self addVertices:vertices];
    }
    
    return self;
    
} // initWithVertices()

- (void)dealloc
{
    
    [_name release];
    [_uuid release];
    
    [_vertices release];
    
    [super dealloc];
    
} // dealloc()

- (NSString *)getUUID
{
    
    return _uuid;
    
} // getUUID()

#pragma mark - System overriden implementation

- (NSString *)description
{
    
    NSMutableString *string = [NSMutableString string];
    
    // First print UUID's directed hyper-edge (and its condition)
    [string appendString:[NSString stringWithFormat:@"Undirected hyper-edge [%@] (%@)\n", _name, [self getUUID]]];
    // Second print the vertices (source and target)
    for (Vertex *v in _vertices) {
        [string appendString:[NSString stringWithFormat:@"\t%@\n", v]];
    }
    
    return string;
    
} // description()


#pragma mark - NSCopying protocol implementation

- (id)copyWithZone:(NSZone *)zone
{
    HyperEdge *objectCopy = [[HyperEdge allocWithZone:zone] init];
    // Copy over all instance variables from self to objectCopy.
    // Use deep copies for all strong pointers, shallow copies for weak.
    return objectCopy;
    
} // copyWithZone()


#pragma mark - HyperEdge protocol implementation

- (BOOL)addVertex:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return FALSE;
    }
    
    if ([self hasVertex:vertex]) {
        return FALSE;
    }
    
    [_vertices addObject:vertex];
    
    return TRUE;
    
} // addVertex()

- (BOOL)addVertices:(NSArray *)vertices
{

    if (vertices == nil) {
        return FALSE;
    }
    if ([vertices count] == 0) {
        return FALSE;
    }
    
    if ([self hasVertices:vertices]) {
        return FALSE;
    }
    
    for (Vertex *v in vertices) {
        [self addVertex:v];
    }
    
    return TRUE;
    
} // addVertices()

- (BOOL)removeVertex:(Vertex *)vertex
{

    if (vertex == nil) {
        return FALSE;
    }
    
    if (![self hasVertex:vertex]) {
        return FALSE;
    }

    [_vertices removeObject:vertex];
    
    return TRUE;
    
} // removeVertex()

- (BOOL)removeVertices:(NSArray *)vertices
{

    if (vertices == nil) {
        return FALSE;
    }
    if ([vertices count] == 0) {
        return FALSE;
    }
    
    if (![self hasVertices:vertices]) {
        return FALSE;
    }    

    for (Vertex *v in vertices) {
        [_vertices removeObject:v];
    }
    
    return TRUE;

} // removeVertices()

- (NSSet *)getVertices
{

    if (_vertices == nil) {
        return nil;
    }
    if ([_vertices count] == 0) {
        return nil;
    }
    
    return _vertices;
    
} // getVertices()

- (NSSet *)getOtherVerticesExcludingVertex:(Vertex *)vertex
{

    if (vertex == nil) {
        return nil;
    }
    
    if (![self hasVertex:vertex]) {
        return nil;
    }

    NSMutableSet *result = [NSMutableSet set];
    for (Vertex *v in _vertices) {
        if (![_vertices containsObject:v]) {
            [result addObject:v];
        }
    }
    
    return result;
    
} // getOtherVerticesExcludingVertex()

- (NSSet *)getOtherVerticesExcludingVertices:(NSArray *)vertices
{

    if (vertices == nil) {
        return nil;
    }
    if ([vertices count] == 0) {
        return nil;
    }
    
    if (![self hasVertices:vertices]) {
        return nil;
    }

    NSMutableSet *result = [NSMutableSet setWithSet:_vertices];
    for (Vertex *v in vertices) {
        [result removeObject:v];
    }
    
    return result;
    
} // getOtherVerticesExcludingVertices()

- (BOOL)connectsVertex:(Vertex *)vertex
{
    
    return [self hasVertex:vertex];
    
} // connectsVertex()

- (BOOL)hasVertex:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return FALSE;
    }
    
    return [_vertices containsObject:vertex];
    
} // hasVertex()

- (BOOL)connectsVertices:(NSArray *)vertices
{
    
    return [self hasVertices:vertices];
    
} // connectsVertices()

- (BOOL)hasVertices:(NSArray *)vertices
{
    
    if (vertices == nil) {
        return FALSE;
    }
    if ([vertices count] == 0) {
        return FALSE;
    }
    
    for (Vertex *v in vertices) {
        if (![_vertices containsObject:v]) {
            return FALSE;
        }
    }
    
    return TRUE;
    
} // hasVertices()

- (NSUInteger)countVertices
{
    
    return [_vertices count];
    
} // countVertices()

- (BOOL)isEqual:(id)object
{
    
    if (object == nil) {
        return FALSE;
    }
    
    if (![object isKindOfClass:[HyperEdge class]]) {
        return FALSE;
    }

    HyperEdge *otherEdge = (HyperEdge *) object;
    
    if ([otherEdge countVertices] != [self countVertices]) {
        return FALSE;
    }
    
    for (Vertex *v in [otherEdge getVertices]) {
        if (![_vertices containsObject:v]) {
            return FALSE;
        }
    }
    
    return TRUE;
    
} // isEqual()

@end
