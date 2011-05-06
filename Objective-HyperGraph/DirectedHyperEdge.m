//
//  DirectedHyperEdge.m
//  Keiko
//
//  Created by Guillermo on 19/04/11.
//  Copyright 2011 Guillermo Rodríguez Cano. All rights reserved.
//

#import "DirectedHyperEdge.h"

#import "NSString+UUID.h"

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

- (void)dealloc
{
    
    [_source dealloc];
    [_target dealloc];
    
    [_uuid dealloc];
    
    [super dealloc];
    
} // dealloc()


#pragma mark - HyperEdge protocol implementation

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

@end
