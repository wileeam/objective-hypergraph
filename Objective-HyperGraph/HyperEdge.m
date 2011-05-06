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

- (void)dealloc
{
    
    [_uuid release];
    [_vertices release];
    
    [super dealloc];
    
} // dealloc()


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

- (BOOL) connectsVertex:(Vertex *)vertex
{
    return false;
}

- (BOOL) connectsVertices:(NSArray *)vertices
{
    return false;
}

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

    NSMutableSet *result = [NSMutableSet setWithSet:_vertices];
    for (Vertex *v in vertices) {
        [result removeObject:v];
    }
    
    return result;
    
} // getOtherVerticesExcludingVertices()

- (BOOL)hasVertex:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return FALSE;
    }
    
    return [_vertices containsObject:vertex];
    
} // hasVertex()

- (BOOL)hasVertices:(NSArray *)vertices
{
    
    if (vertices == nil) {
        return FALSE;
    }
    
    for (Vertex *v in vertices) {
        if (![_vertices containsObject:v]) {
            return FALSE;
        }
    }
    
    return TRUE;
    
} // hasVertices()

@end
