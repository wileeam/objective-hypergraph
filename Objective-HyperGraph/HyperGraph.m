/*
 * HyperGraph.m
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


#import "HyperGraph.h"


@implementation HyperGraph

#pragma mark - Initialisation and memory management

- (id)init
{
    
    // Parent initialisation's check and adjacent matrix's population
	if ((self = [super init]) != nil) {
        _uuid = [NSString stringWithUUID];
        
        _vertices = [NSMutableDictionary dictionary];
        _edges = [NSMutableDictionary dictionary];        
    }
    
    return self;
    
} // init()

- (void)dealloc
{

    [_vertices dealloc];
    [_edges dealloc];

    [_uuid dealloc];
    
    [super dealloc];
    
} // dealloc()

- (NSString *)getUUID
{
    
    return _uuid;
    
} // getUUID()


#pragma mark - HyperGraph protocol implementation

- (HyperEdge *)addEdgeFromVertex:(Vertex *)vertex
{
    if (vertex == nil) {
        return nil;
    }
    
    // First check for vertex to exist (if not, we can safely assume the edge will be valid)
    NSMutableSet *edgesForVertex = [_vertices objectForKey:vertex];
    if (edgesForVertex != nil && [edgesForVertex count] != 0) {
        for (HyperEdge *e in edgesForVertex) {
            if ([e countVertices] == 1 && [e hasVertex:vertex]) {
                return e;
            }
        }
    }
    
    // Second create edge since it didn't exist
    HyperEdge *edge = [[[HyperEdge alloc] initWithVertex:vertex] autorelease];
    
    // Third add both the vertex and the edge to corresponding dictionaries
    if (edgesForVertex == nil) {
        edgesForVertex = [NSMutableSet set];
        [_vertices setObject:edgesForVertex forKey:vertex];
    }
    [edgesForVertex addObject:edge];
    
    NSMutableSet *verticesForEdge = [NSMutableSet set];
    [verticesForEdge addObject:vertex];
    [_edges setObject:verticesForEdge forKey:edge];
    
    //Fourth let caller know how successful we were :) and... voilà!
    return edge;
    
} // addEdgeFromVertex()

- (HyperEdge *)addEdgeFromVertices:(NSArray *)vertices;
{
    
    if (vertices == nil) {
        return nil;
    }
    if ([vertices count] == 0) {
        return nil;
    }

    // First check for vertices to exist (if not, we can safely assume the edge will be valid)
    NSMutableSet *edgesForVertices = [NSMutableSet set];
    for (Vertex *v in vertices) {
        for (HyperEdge *e in [_vertices objectForKey:v]) {
            if (![edgesForVertices containsObject:e]) {                
                if ([e hasVertices:vertices]) {
                    return e;
                }
                [edgesForVertices addObject:e];
            }
        }
    }

    // Second create edge since it didn't exist
    HyperEdge *edge = [[[HyperEdge alloc] initWithVertices:vertices] autorelease];

    // Third add both the vertices and the edge to corresponding dictionaries    
    for (Vertex *v in vertices) {
        NSMutableSet *edgesForVertex = [_vertices objectForKey:v];
        if (edgesForVertex == nil) {
            edgesForVertex = [NSMutableSet set];
            [_vertices setObject:edgesForVertex forKey:v];            
        }
        [edgesForVertex addObject:edge];
    }
    
    NSMutableSet *verticesForEdge = [NSMutableSet set];
    [verticesForEdge addObjectsFromArray:vertices];
    [_edges setObject:verticesForEdge forKey:edge];
    
    //Fourth let caller know how successful we were :) and... voilà!
    return edge;
    
} // addEdgeFromVertices()

- (BOOL)addVertex:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return FALSE;
    }
    
    if ([self hasVertex:vertex]) {
        return FALSE;
    }
    
    [_vertices setObject:nil forKey:vertex];
    
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
        [_vertices setObject:nil forKey:v];        
    }
    
    return TRUE;
    
} // addVertices()

- (BOOL)removeEdge:(HyperEdge *)edge
{
    
    if (edge != nil) {
        return FALSE;
    }
    
    if (![self hasEdge:edge]) {
        return FALSE;
    }

    // First remove edge for each vertex from vertices dictionary
    NSMutableSet *verticesForEdge = [_edges objectForKey:edge];
    for (Vertex *v in verticesForEdge) {
        NSMutableSet *edgesForVertex = [_vertices objectForKey:v];
        [edgesForVertex removeObject:edge];
    }
    
    // Second remove edge from edges dictionary and free memory
    [_edges removeObjectForKey:edge];

    [edge release];
    
    return TRUE;
    
} // removeEdge()

- (BOOL)removeEdges:(NSArray *)edges
{

    if (edges != nil) {
        return FALSE;
    }
    if ([edges count] == 0) {
        return FALSE;
    }
    
    if (![self hasEdges:edges]) {
        return FALSE;
    }
    

    for (HyperEdge *e in edges) {
        // First remove edge for each vertex from vertices dictionary
        NSMutableSet *verticesForEdge = [_edges objectForKey:e];
        for (Vertex *v in verticesForEdge) {
            NSMutableSet *edgesForVertex = [_vertices objectForKey:v];
            [edgesForVertex removeObject:e];
        }

        // Second remove edge from edges dictionary and free memory
        [_edges removeObjectForKey:e];
        
        [e release];
        [verticesForEdge release];
    }
    
    return TRUE;
        
} // removeEdges()

- (BOOL)removeVertex:(Vertex *)vertex;
{
    if (vertex == nil) {
        return FALSE;
    }
    
    if ([self hasVertex:vertex]) {
        return FALSE;
    }    
    
    NSMutableSet *edgesForVertex = [_vertices objectForKey:vertex];
    if (edgesForVertex != nil && [edgesForVertex count] != 0) {
        return FALSE;
    }
    
    [_vertices removeObjectForKey:vertex];
    
    return TRUE;
    
} // removeVertex()

- (BOOL)removeVertices:(NSArray *)vertices;
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
        NSMutableSet *edgesForVertex = [_vertices objectForKey:v];
        if (edgesForVertex != nil && [edgesForVertex count] != 0) {
            return FALSE;
        }
    }
    
    for (Vertex *v in vertices) {
        [_vertices removeObjectForKey:v];
    }
    
    return TRUE;
    
} // removeVertices()

- (NSArray *)getEdges;
{
    
    NSArray *edges = [_edges allKeys];

    if ([edges count] == 0) {
        return nil;
    }
    
    return edges;

} // getEdges()

- (NSArray *)getEdgesConnectingVertices:(NSArray *)vertices
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
    
    NSMutableSet *edgesConnectingVertices = [NSMutableSet setWithArray:[self getEdges]];
    for (Vertex *v in vertices) {
        NSSet *edgesUsingVertex =  [NSSet setWithArray:[self getEdgesUsingVertex:v]];
        [edgesConnectingVertices intersectSet:edgesUsingVertex];
    }
    
    return [edgesConnectingVertices allObjects];
    
} // getEdgesConnectingVertices()

- (NSArray *)getEdgesUsingVertex:(Vertex *)vertex;
{
    
    if (vertex == nil) {
        return nil;
    }
    
    if (![self hasVertex:vertex]) {
        return nil;
    }
        
    return [_edges allKeysForObject:vertex];
    
} // getEdgesConnectingVertex()

- (NSArray *)getEdgesUsingVertices:(NSArray *)vertices;
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

    NSMutableSet *edgesForVertices = [NSMutableSet set];
    for (Vertex *v in vertices) {
        [edgesForVertices addObjectsFromArray:[_edges allKeysForObject:v]];
    }

    return [edgesForVertices allObjects];
    
} // getEdgesConnectingVertices()


- (NSArray *)getVertices
{
    
    NSArray *vertices = [_vertices allKeys];

    if ([vertices count] == 0) {
        return nil;
    }
    
    return vertices;
    
} // getVertices()


- (BOOL)hasVertex:(Vertex *)vertex
{

    if (vertex == nil) {
        return FALSE;
    }    
    
    NSArray *verticesInHyperGraph = [self getVertices];
    
    if (verticesInHyperGraph == nil) {
        return FALSE;
    }
    
    return [verticesInHyperGraph containsObject:vertex];
    
} // hasVertex()

- (BOOL)hasVertices:(NSArray *)vertices
{

    if (vertices == nil) {
        return FALSE;
    }
    if ([vertices count] == 0) {
        return FALSE;
    }    

    NSArray *verticesInHyperGraph = [self getVertices];
    
    if (verticesInHyperGraph == nil) {
        return FALSE;
    }    
    
    for (Vertex *v in vertices) {
        if (![verticesInHyperGraph containsObject:v]) {
            return FALSE;
        }
    }
    
    return TRUE;    
    
} // hasVertices()

- (BOOL)hasEdge:(HyperEdge *)edge;
{
    
    if (edge == nil) {
        return FALSE;
    }    
    
    NSArray *edgesInHyperGraph = [self getEdges];
    
    if (edgesInHyperGraph == nil) {
        return FALSE;
    }
    
    return [edgesInHyperGraph containsObject:edge];
    
} // hasEdge()

- (BOOL)hasEdges:(NSArray *)edges
{
    
    if (edges == nil) {
        return FALSE;
    }
    if ([edges count] == 0) {
        return FALSE;
    }    
    
    NSArray *edgesInHyperGraph = [self getEdges];
    
    if (edgesInHyperGraph == nil) {
        return FALSE;
    }    
    
    for (HyperEdge *e in edges) {
        if (![edgesInHyperGraph containsObject:e]) {
            return FALSE;
        }
    }
    
    return TRUE;    
    
} // hasEdges()

- (NSArray *)getConnectedVertices
{
    
    NSMutableArray *vertices = [NSMutableArray array];
    
    for (Vertex *v in [self getVertices]) {
        if ([_vertices objectForKey:v] != nil && [[_vertices objectForKey:v] count] > 0) {
            [vertices addObject:v];
        }
    }
    
    if ([vertices count] == 0) {
        return nil;
    }
    
    return vertices;
    
} // getConnectedVertices()

- (NSArray *)getDisconnectedVertices;
{
    
    NSMutableArray *vertices = [NSMutableArray array];
    
    for (Vertex *v in [self getVertices]) {
        if ([_vertices objectForKey:v] == nil || [[_vertices objectForKey:v] count] == 0) {
            [vertices addObject:v];
        }
    }
    
    if ([vertices count] == 0) {
        return nil;
    }
    
    return vertices;    
    
} // getDisconnectedVertices()

- (BOOL)areAdjacent:(NSArray *)vertices;
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
    
    NSArray *connectingEdges = [self getEdgesConnectingVertices:vertices];
    
    if (connectingEdges == nil) {
        return FALSE;
    }
    
    return [connectingEdges count] > 0;
    
} // areAdjacent()

- (NSArray *)getAdjacentToVertex:(Vertex *)vertex;
{
    
    if (vertex == nil) {
        return nil;
    }
    
    if (![self hasVertex:vertex]) {
        return nil;
    }    
    
    NSArray *edges = [_edges allKeysForObject:vertex];
    
    NSMutableSet *adjacentVertices = [NSMutableSet set];
    for (HyperEdge *e in edges) {
        [adjacentVertices addObjectsFromArray:[[_edges objectForKey:e] allObjects]];
    }
    
    if ([adjacentVertices count] == 0) {
        return nil;
    }
    
    // Remove the parameter
    [adjacentVertices removeObject:vertex];
    
    return [adjacentVertices allObjects];

} // getAdjacentToVertex()

- (NSArray *)getAdjacentToVertices:(NSArray *)vertices;
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
    
    NSArray *edges = [self getEdgesConnectingVertices:vertices];
    
    NSMutableSet *adjacentVertices = [NSMutableSet set];
    for (HyperEdge *e in edges) {
        [adjacentVertices addObjectsFromArray:[[_edges objectForKey:e] allObjects]];
    }
    
    if ([adjacentVertices count] == 0) {
        return nil;
    }
    
    // Remove the parameter
    [adjacentVertices minusSet:[NSSet setWithArray:vertices]];
    
    return [adjacentVertices allObjects];
    
} // getAdjacentToVertices()

- (NSUInteger)countVertices
{
    
    return [[self getVertices] count];
    
} // countVertices()

- (NSUInteger)countEdges
{
    
    return [[self getEdges ] count];
    
} // countEdges()

- (BOOL)isMultiGraph
{
    // TODO
    // Current implementation does check for duplicate edges, and so by definiton a multigraph is not possible
    return FALSE;
    
} // isMultiGraph()

@end
