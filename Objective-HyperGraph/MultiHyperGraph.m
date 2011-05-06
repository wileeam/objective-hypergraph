//
//  MultiHyperGraph.m
//  Keiko
//
//  Created by Guillermo on 19/04/11.
//  Copyright 2011 Guillermo Rodríguez Cano. All rights reserved.
//

#import "MultiHyperGraph.h"


@implementation MultiHyperGraph

#pragma mark - Initialisation and memory management

- (id)init
{
    
    // Parent initialisation's check and adjacent matrix's population
	if ((self = [super init]) != nil) {

    }
    
    return self;
    
} // init()

- (void)dealloc
{
        
    [super dealloc];
    
} // dealloc()

#pragma mark -

- (HyperEdge *)addEdgeFromVertex:(Vertex *)vertex
{
    
    HyperEdge *e = [HyperEdge new];
    [e addVertex:vertex];
    
    return e;
    
} // addEdgeFromVertex()

- (HyperEdge *)addEdgeFromVertices:(NSArray *)vertices
{

    HyperEdge *e = [HyperEdge new];
    [e addVertices:vertices];
    
    return e;
    
} // addEdgeFromVertices()

- (Vertex *)addVertex:(Vertex *)vertex
{

    if (vertex == nil) {
        return nil;
    }
    
    if ([self containsVertex:vertex]) {
        return nil;
    }
    
    CFDictionaryAddValue(_vertices, vertex, [NSMutableSet set]);
    
    return vertex;
    
} // addVertex()

- (NSArray *)addVertices:(NSArray *)vertices
{
    
    if (vertices == nil) {
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (Vertex *v in vertices) {
        if ([self addVertex:v] != nil) {
            [result addObject:v];
        }
    }
    
    if ([result count] > 0) {
        return result;
    } else {
        [result release];
        return nil;
    }
    
} // addVertices()

- (HyperEdge *)removeEdge:(HyperEdge *)edge
{
    
    if (edge == nil) {
        return nil;
    }
    
    if ([self containsEdge:edge]) {
        [edge destroy];
        return edge;
    } else {
        return nil;
    }
    
} // removeEdge()

- (NSArray *)removeEdges:(NSArray *)edges
{
    
    if (edges == nil) {
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (HyperEdge *e in edges) {
        if ([self removeEdge:e] != nil) {
            [result addObject:e];
        }
    }
    
    if ([result count] > 0) {
        return result;
    } else {
        [result release];
        return nil;
    }
    
} // removeEdges()

- (Vertex *)removeVertex:(Vertex *)vertex
{

    if (vertex == nil) {
        return nil;
    }
    
    if ([self containsVertex:vertex]) {
        NSArray *es = [self getEdgesConnectingVertex:vertex];
        for (HyperEdge *e in es) {
            [e removeVertex:vertex];
        }

        CFDictionaryRemoveValue(_vertices, vertex);        
        return vertex;
    }
    
    return nil;
    
} // removeVertex()

- (NSArray *)removeVertices:(NSArray *)vertices
{
    
    if (vertices != nil || [vertices count] == 0) {
        return nil;
    }
    
    NSArray *es = [self getEdgesConnectingVertex:[vertices objectAtIndex:0]];
    for (HyperEdge *e in es) {
        [e removeVertices:vertices];
    }
    
    return vertices;
    
} // removeVertices()

- (NSArray *)getEdges
{

    CFTypeRef *result = (CFTypeRef *) malloc(CFDictionaryGetCount(_edges)*sizeof(CFTypeRef));
    CFDictionaryGetKeysAndValues(_edges, (const void **) result, NULL);
    const void **keys = (const void **) result;

    if (keys == NULL) {
        return [NSArray array];
    } else {
        NSMutableArray *res = [NSMutableArray array];
        for (int i = 0; i < CFDictionaryGetCount(_edges); i++) {
            [res addObject:keys[i]];
        }
        
        free(keys);
        
        return res;
    }
    
} // getEdges()

- (NSArray *)getEdgesConnectingVertex:(Vertex *)vertex;
- (NSArray *)getEdgesConnectingVertices:(NSArray *)vertices;

- (BOOL)containsVertex:(Vertex *)vertex;
- (BOOL)containsEdge:(HyperEdge *)edge;

- (NSArray *)getConnectedVertices;
- (NSArray *)getDisconnectedVertices;

- (BOOL)areAdjacent:(NSArray *)vertices;
- (NSArray *)getAdjacent:(Vertex *)vertex;

- (NSUInteger *)countVertices;
- (NSUInteger *)countEdges;

- (BOOL)isMultiGraph;

@end
