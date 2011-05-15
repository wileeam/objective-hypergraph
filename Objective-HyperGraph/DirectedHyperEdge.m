/*
 * DirectedHyperEdge.m
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


#import "DirectedHyperEdge.h"


@implementation DirectedHyperEdge

#pragma mark - Initialisation and memory management

- (id)init
{
    
    // Parent initialisation's check and adjacent matrix's population
	if ((self = [super init]) != nil) {
        _source = [NSMutableSet set];
        _target = [NSMutableSet set];
    }
    
    return self;
    
} // init()

- (id)initWithSourceVertex:(Vertex *)vertex
{
    
    if ([self init] != nil) {
        [self addSourceVertex:vertex];
    }
    
    return self;
    
} // initWithSourceVertex()

- (id)initWithSourceVertices:(NSArray *)vertices
{
    
    if ([self init] != nil) {
        [self addSourceVertices:vertices];
    }
    
    return self;
    
} // initWithSourceVertices()

- (id)initWithTargetVertex:(Vertex *)vertex
{
    
    if ([self init] != nil) {
        [self addTargetVertex:vertex];
    }
    
    return self;
    
} // initWithTargetVertex()

- (id)initWithTargetVertices:(NSArray *)vertices
{
    
    if ([self init] != nil) {
        [self addTargetVertices:vertices];
    }
    
    return self;
    
} // initWithTargetVertices()

- (id)initWithSourceAndTargetVertex:(Vertex *)source:(Vertex *)target
{
    
    if ([self init] != nil) {
        [self addSourceAndTargetVertices:[NSArray arrayWithObject:source] :[NSArray arrayWithObject:target]];
    }
    
    return self;
    
} // initWithSourceAndTargetVertex()

- (id)initWithSourceAndTargetVertices:(NSArray *)source:(NSArray *)target
{
    
    if ([self init] != nil) {
        [self addSourceAndTargetVertices:source :target];
    }
    
    return self;
    
} // initWithSourceAndTargetVertices()


- (void)dealloc
{

    [_source release];
    [_target release];
    
    [super dealloc];
    
} // dealloc()


#pragma mark - System overriden implementation

- (NSString *)description
{

    NSMutableString *string = [NSMutableString string];

    // First print UUID's directed hyper-edge (and its condition)
    [string appendString:[NSString stringWithFormat:@"Directed hyper-edge [%@] (%@)\n", self.name, [self getUUID]]];
    // Second print the vertices (source and target)
    [string appendString:[NSString stringWithFormat:@"\tSource vertices\n"]];
    for (Vertex *v in _source) {
        [string appendString:[NSString stringWithFormat:@"\t\t%@\n", v]];
    }
    [string appendString:[NSString stringWithFormat:@"\tTarget vertices\n"]];    
    for (Vertex *v in _target) {
        [string appendString:[NSString stringWithFormat:@"\t\t%@\n", v]];        
    }
    
    return string;
    
} // description()


#pragma mark - NSCopying protocol implementation

- (id)copyWithZone:(NSZone *)zone
{
    DirectedHyperEdge *objectCopy = [[DirectedHyperEdge allocWithZone:zone] init];
    // Copy over all instance variables from self to objectCopy.
    // Use deep copies for all strong pointers, shallow copies for weak.
    return objectCopy;
    
} // copyWithZone()


#pragma mark - DirectedHyperEdge protocol implementation

- (BOOL)addSourceVertex:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return FALSE;
    }
    
    if (![self hasVertex:vertex]) {
        return FALSE;
    }
    
    [_source addObject:vertex];
    [_vertices addObject:vertex];
    
    return TRUE;
        
} // addSourceVertex()

- (BOOL)addSourceVertices:(NSArray *)vertices
{
    
    if (vertices == nil) {
        return FALSE;
    }
    if ([vertices count] == 0) {
        return FALSE;
    }
    
    if (![self hasSourceWithVertices:vertices]) {
        return FALSE;
    }
    
    [_source addObjectsFromArray:vertices];
    [_vertices addObjectsFromArray:vertices];
    
    return TRUE;
    
} // addSourceVertices()

- (BOOL)addTargetVertex:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return FALSE;
    }
    
    if (![self hasTargetWithVertex:vertex]) {
        return FALSE;
    }
    
    [_target addObject:vertex];
    [_vertices addObject:vertex];
    
    return TRUE;
    
} // addTargetVertex()

- (BOOL)addTargetVertices:(NSArray *)vertices;
{

    if (vertices == nil) {
        return FALSE;
    }
    if ([vertices count] == 0) {
        return FALSE;
    }
    
    if ([self hasTargetWithVertices:vertices]) {
        return FALSE;
    }
    
    [_target addObjectsFromArray:vertices];
    [_vertices addObjectsFromArray:vertices];
    
    return TRUE;

} // addTargetVertices()

- (BOOL)addSourceAndTargetVertices:(NSArray *)sourceVertices:(NSArray *)targetVertices
{

    if (sourceVertices == nil) {
        return FALSE;
    }
    if ([sourceVertices count] == 0) {
        return FALSE;
    }
    if (targetVertices == nil) {
        return FALSE;
    }
    if ([targetVertices count] == 0) {
        return FALSE;
    }

    if ([self hasSourceWithVertices:sourceVertices]) {
        return FALSE;
    }    
    if ([self hasTargetWithVertices:targetVertices]) {
        return FALSE;
    }

    [_source addObjectsFromArray:sourceVertices];
    [_target addObjectsFromArray:targetVertices];
    [_vertices addObjectsFromArray:sourceVertices];
    [_vertices addObjectsFromArray:targetVertices];    
    
    return TRUE;
    
} // addSourceAndTargetVertices()

- (BOOL)removeSourceVertex:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return FALSE;
    }
    
    if (![self hasSourceWithVertex:vertex]) {
        return FALSE;
    }
    
    [_source removeObject:vertex];
    if (![self hasTargetWithVertex:vertex]) {
        [_vertices removeObject:vertex];
    }
    
    return TRUE;
    
} // removeSourceVertex()

- (BOOL)removeSourceVertices:(NSArray *)vertices
{

    if (vertices == nil) {
        return FALSE;
    }
    if ([vertices count] == 0) {
        return FALSE;
    }
    
    if (![self hasSourceWithVertices:vertices]) {
        return FALSE;
    }    
    
    for (Vertex *v in vertices) {
        [_source removeObject:v];
    }
    if (![self hasTargetWithVertices:vertices]) {
        for (Vertex *v in vertices) {
            [_vertices removeObject:v];
        }
    }
    
    return TRUE; 
    
} // removeSourceVertices()

- (BOOL)removeTargetVertex:(Vertex *)vertex
{

    if (vertex == nil) {
        return FALSE;
    }
    
    if (![self hasTargetWithVertex:vertex]) {
        return FALSE;
    }
    
    [_target removeObject:vertex];
    if (![self hasSourceWithVertex:vertex]) {
        [_vertices removeObject:vertex];
    }
    
    return TRUE; 
    
} // removeTargetVertex()

- (BOOL)removeTargetVertices:(NSArray *)vertices
{

    if (vertices == nil) {
        return FALSE;
    }
    if ([vertices count] == 0) {
        return FALSE;
    }

    if (![self hasTargetWithVertices:vertices]) {
        return FALSE;
    }    
    
    for (Vertex *v in vertices) {
        [_target removeObject:v];
    }
    if (![self hasSourceWithVertices:vertices]) {
        for (Vertex *v in vertices) {
            [_vertices removeObject:v];
        }
    }
    
    return TRUE;    
    
} // removeTargetVertices()

- (BOOL)removeSourceAndTargetVertices:(NSArray *)sourceVertices:(NSArray *)targetVertices
{
    
    if (sourceVertices == nil) {
        return FALSE;
    }
    if ([sourceVertices count] == 0) {
        return FALSE;
    }
    if (targetVertices == nil) {
        return FALSE;
    }
    if ([targetVertices count] == 0) {
        return FALSE;
    }

    if ([self hasSourceWithVertices:sourceVertices]) {
        return FALSE;
    }    
    if ([self hasTargetWithVertices:targetVertices]) {
        return FALSE;
    }

    for (Vertex *v in sourceVertices) {
        [_source removeObject:v];
    }    
    for (Vertex *v in targetVertices) {
        [_target removeObject:v];
    }
    if (![self hasTargetWithVertices:sourceVertices]) {
        for (Vertex *v in sourceVertices) {
            [_vertices removeObject:v];
        }
    }    
    if (![self hasSourceWithVertices:targetVertices]) {
        for (Vertex *v in targetVertices) {
            [_vertices removeObject:v];
        }
    }    

    return TRUE;    
    
} // removeSourceAndTargetVertices()

- (NSSet *)getSourceVertices
{
    
    return _source;
    
} // getSourceVertices()

- (NSSet *)getOtherSourceVerticesExcludingVertex:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return nil;
    }
    
    NSMutableSet *result = [NSMutableSet set];
    for (Vertex *v in _vertices) {
        if (![_source containsObject:v]) {
            [result addObject:v];
        }
    }
    
    return result;
    
} // getOtherSourceVerticesAsVertex()

- (NSSet *)getOtherSourceVerticesExcludingVertices:(NSArray *)vertices
{

    if (vertices == nil) {
        return nil;
    }
    if ([vertices count] == 0) {
        return nil;
    }
    
    NSMutableSet *result = [NSMutableSet setWithSet:_source];
    for (Vertex *v in vertices) {
        [result removeObject:v];
    }
    
    return result;
    
} // getOtherSourceVerticesAsVertices()

- (NSSet *)getTargetVertices
{
    
    return _target;
    
} // getTargetVertices()

- (NSSet *)getOtherTargetVerticesExcludingVertex:(Vertex *)vertex
{

    if (vertex == nil) {
        return nil;
    }
    
    NSMutableSet *result = [NSMutableSet set];
    for (Vertex *v in _vertices) {
        if (![_target containsObject:v]) {
            [result addObject:v];
        }
    }
    
    return result;    
    
} // getOtherTargetVerticesAsVertex()

- (NSSet *)getOtherTargetVerticesExcludingVertices:(NSArray *)vertices
{

    if (vertices == nil) {
        return nil;
    }
    if ([vertices count] == 0) {
        return nil;
    }
    
    NSMutableSet *result = [NSMutableSet setWithSet:_target];
    for (Vertex *v in vertices) {
        [result removeObject:v];
    }
    
    return result;    
    
} // getOtherTargetVerticesAsVertices()

- (BOOL)hasSource
{
    
    return ([_source count] != 0);
    
} // hasSource()

- (BOOL)hasSourceWithVertex:(Vertex *)vertex
{
    
    return [_source containsObject:vertex];
    
} // hasSourceWithVertex()

- (BOOL)hasSourceWithVertices:(NSArray *)vertices
{
    
    for (Vertex *v in vertices) {
        if (![self hasSourceWithVertex:v]) {
            return FALSE;
        }
    }
    
    return TRUE;
    
} // hasSourceWithVertices()

- (BOOL)hasTarget
{
    
    return ([_target count] != 0);
    
} // hasTarget()

- (BOOL)hasTargetWithVertex:(Vertex *)vertex
{
 
    return [_target containsObject:vertex];    
    
} // hasTargetWithVertex()

- (BOOL)hasTargetWithVertices:(NSArray *)vertices;
{
    
    for (Vertex *v in vertices) {
        if (![self hasTargetWithVertex:v]) {
            return FALSE;
        }
    }
    
    return TRUE;    
    
} // hasTargetWithVertices()

- (NSUInteger)countSourceVertices
{
    
    return [_source count];
    
} // countSourceVertices()

- (NSUInteger)countTargetVertices
{
    
    return [_target count];
    
} // countTargetVertices()

- (BOOL)isEqual:(id)object
{
    
    if (object == nil) {
        return FALSE;
    }
    
    if (![object isKindOfClass:[DirectedHyperEdge class]]) {
        return FALSE;
    }
    
    DirectedHyperEdge *otherEdge = (DirectedHyperEdge *) object;
    
    if ([otherEdge countVertices] != [self countVertices]) {
        return FALSE;
    }
    if ([otherEdge countSourceVertices] != [self countSourceVertices]) {
        return FALSE;
    }
    if ([otherEdge countTargetVertices] != [self countTargetVertices]) {
        return FALSE;
    }    
    
    for (Vertex *v in [otherEdge getSourceVertices]) {
        if (![_source containsObject:v]) {
            return FALSE;
        }
    }
    for (Vertex *v in [otherEdge getTargetVertices]) {
        if (![_target containsObject:v]) {
            return FALSE;
        }
    }
    
    return TRUE;
    
} // isEqual()


#pragma mark - HyperEdge proocol overriden implementation

- (id)initWithVertex:(Vertex *)vertex
{

    @throw [NSException exceptionWithName:@"OperationNotAllowedException" reason:@"Method usage not allowed" userInfo:nil];
        
} // initWithVertex()

- (id)initWithVertices:(NSArray *)vertices
{

    @throw [NSException exceptionWithName:@"OperationNotAllowedException" reason:@"Method usage not allowed" userInfo:nil];
    
} // initWithVertices()

- (BOOL)addVertex:(Vertex *)vertex
{
    
    @throw [NSException exceptionWithName:@"OperationNotAllowedException" reason:@"Method usage not allowed" userInfo:nil];
    
} // addVertex()

- (BOOL)addVertices:(NSArray *)vertices
{
    
    @throw [NSException exceptionWithName:@"OperationNotAllowedException" reason:@"Method usage not allowed" userInfo:nil];
    
} // addVertices()

- (BOOL)removeVertex:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return FALSE;
    }
    
    return [self removeSourceVertex:vertex] || [self removeTargetVertex:vertex];
    
} // removeVertex()

- (BOOL)removeVertices:(NSArray *)vertices
{
    
    if (vertices == nil) {
        return FALSE;
    }
    
    if ([vertices count] == 0) {
        return FALSE;
    }
    
    return [self removeSourceVertices:vertices] || [self removeTargetVertices:vertices];
    
} // removeVertices()

- (BOOL)hasVertex:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return FALSE;
    }
    
    return [_source containsObject:vertex] || [_target containsObject:vertex];
    
} // hasVertex()

- (BOOL)hasVertices:(NSArray *)vertices
{
    
    if (vertices == nil) {
        return FALSE;
    }
    if ([vertices count] == 0) {
        return FALSE;
    }
    
    for (Vertex *v in vertices) {
        if (!([_source containsObject:v] || [_target containsObject:v])) {
            return FALSE;
        }
    }
    
    return TRUE;
    
} // hasVertices()

- (NSUInteger)countVertices
{
    
    return [_source count] + [_target count];
    
} // countVertices()

@end
