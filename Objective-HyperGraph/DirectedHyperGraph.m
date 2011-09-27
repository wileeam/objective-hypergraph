/*
 * DirectedHyperGraph.m
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


#import "DirectedHyperGraph.h"


@implementation DirectedHyperGraph


- (DirectedHyperEdge *)addEdgeWithSourceVertex:(Vertex *)source withTargetVertex:(Vertex *)target
{

    NSArray *sourceArray = [NSArray arrayWithObject:source];
    NSArray *targetArray = [NSArray arrayWithObject:target];    
    
    return [self addEdgeWithSourceVertices:sourceArray withTargetVertices:targetArray];
    
} // addEdgeWithSourceVertex()

- (DirectedHyperEdge *)addEdgeWithSourceVertex:(Vertex *)source withTargetVertices:(NSArray *)target
{

    NSArray *sourceArray = [NSArray arrayWithObject:source];
    
    return [self addEdgeWithSourceVertices:sourceArray withTargetVertices:target];
    
} // addEdgeWithSourceVertex()

- (DirectedHyperEdge *)addEdgeWithSourceVertices:(NSArray *)source withTargetVertices:(NSArray *)target
{

    if (source == nil || target == nil) {
        return nil;
    }    
    if ([source count] == 0 || [target count] == 0) {
        return nil;
    }
    
    // First check for edges with source and target vertices (if not, we can safely assume the edge will be valid)
    NSSet *edgesForSourceAndTargetVertices = [NSSet setWithArray:[self findEdgesWithSourceVertices:source withTargetVertices:target]];
    if (edgesForSourceAndTargetVertices != nil && [edgesForSourceAndTargetVertices count] != 0) {
        return [edgesForSourceAndTargetVertices anyObject];
    }
    
    // Second create edge since we didn't find any
    DirectedHyperEdge *edge = [[DirectedHyperEdge alloc] initWithSourceAndTargetVertices:source :target];
    
    // Third add both the source and target vertices and the edge to corresponding dictionaries
    NSSet *sourceSet = [NSSet setWithArray:source];
    NSSet *targetSet = [NSSet setWithArray:target];
    NSMutableSet *vertices = [NSMutableSet setWithSet:sourceSet];
    [vertices unionSet:targetSet];
    // Check whether vertex exists or not, and add the newly created edge to the set of each involved vertex
    for (Vertex *v in vertices) {
        NSMutableSet *vSet = [_vertices objectForKey:v];
        if (vSet == nil) {
            vSet = [NSMutableSet set];
            [_vertices setObject:vSet forKey:v];
        }
        [vSet addObject:edge];
    }
    // Add all vertices involved in the newly created edge (which does not exist in the corresponding dictionary)    
    [_edges setObject:vertices forKey:edge];
    
    //Fourth let caller know how successful we were :) and... voilà!
    return edge;
    
} // addEdgeWithSourceVertices()

- (DirectedHyperEdge *)addEdgeWithSourceVertices:(NSArray *)source withTargetVertex:(Vertex *)target
{

    NSArray *targetArray = [NSArray arrayWithObject:target];    
    
    return [self addEdgeWithSourceVertices:source withTargetVertices:targetArray];  

} // addEdgeWithSourceVertices()

- (NSArray *)getPredecessors:(Vertex *)vertex
{

    if (vertex == nil) {
        return nil;
    }

    NSMutableSet *predecessors = [NSMutableSet set];
    
    NSArray *incomingEdges = [self getIncomingEdges:vertex];
    for (DirectedHyperEdge *e in incomingEdges) {
        [predecessors unionSet:[e getSourceVertices]];
    }
    
    return [predecessors allObjects];
    
} // getPredecessors()

- (NSArray *)getSuccessors:(Vertex *)vertex
{

    if (vertex == nil) {
        return nil;
    }
    
    NSMutableSet *successors = [NSMutableSet set];

    NSArray *outgoingEdges = [self getOutgoingEdges:vertex];    
    for (DirectedHyperEdge *e in outgoingEdges) {
        [successors unionSet:[e getTargetVertices]];
    }
    
    return [successors allObjects];
    
} // getSuccessors()

- (NSArray *)getIncomingEdges:(Vertex *)vertex
{
    
    return [self findEdgesWithTargetVertex:vertex];
    
} // getIncomingEdges()

- (NSArray *)getOutgoingEdges:(Vertex *)vertex
{
    
    return [self findEdgesWithSourceVertex:vertex];
    
} // getOutgoingEdges()

- (NSArray *)backwardStar:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return nil;
    }    
    
    // First get all edges
    NSMutableSet *edges = [NSMutableSet setWithArray:[self getEdges]];
    
    // Second intersect parameter vertex's set of edges with set of all edges to get edges with source vertices at least
    [edges intersectSet:[_vertices objectForKey:vertex]];
    
    // Third verify that remaining edges' target vertices sets correspond with vertices' set parameter
    if ([edges count] != 0) {
        for (DirectedHyperEdge *e in edges) {
            if (![e containsVertexInTarget:vertex]) {
                // Remove the current edge because its target vertices set does not contain the parameter vertex
                [edges removeObject:e];
            }
        }
    }
    
    // Fourth return the remaining edges which do conform with the specification
    return [edges allObjects];
    
} // backwardStar()

- (NSArray *)forwardStar:(Vertex *)vertex
{
    
    if (vertex == nil) {
        return nil;
    }    
    
    // First get all edges
    NSMutableSet *edges = [NSMutableSet setWithArray:[self getEdges]];
    
    // Second intersect parameter vertex's set of edges with set of all edges to get edges with source vertices at least
    [edges intersectSet:[_vertices objectForKey:vertex]];
    
    // Third verify that remaining edges' source vertices sets correspond with vertices' set parameter
    if ([edges count] != 0) {
        for (DirectedHyperEdge *e in edges) {
            if (![e containsVertexInSource:vertex]) {
                // Remove the current edge because its source vertices set does not contain the parameter vertex
                [edges removeObject:e];
            }
        }
    }
    
    // Fourth return the remaining edges which do conform with the specification
    return [edges allObjects];
    
} // forwardStar()

- (NSArray *)findEdgesWithSourceVertex:(Vertex *)source
{
    
    NSArray *sourceArray = [NSArray arrayWithObject:source];
    
    return [self findEdgesWithSourceVertices:sourceArray];
    
} // findEdgesWithSourceVertex()

- (NSArray *)findEdgesWithSourceVertices:(NSArray *)source
{
    
    if (source == nil) {
        return nil;
    }    
    if ([source count] == 0) {
        return nil;
    }
    
    // First get all edges
    NSMutableSet *edges = [NSMutableSet setWithArray:[self getEdges]];
    
    // Second intersect each source vertex's set of edges with set of all edges to get edges with source vertices at least
    for (Vertex *v in source) {
        [edges intersectSet:[_vertices objectForKey:v]];
    }
    
    // Third verify that remaining edges' source vertices sets correspond with vertices' set parameter
    if ([edges count] != 0) {
        for (DirectedHyperEdge *e in edges) {
            // Note that we validate that vertices set parameter is equal to each remaining source edge's vertices set            
            if (![e countSourceVertices] == [source count] || ![e hasSourceWithVertices:source]) {
                // Remove the current edge because its source vertices set is not equal to the parameter
                [edges removeObject:e];
            }
        }
    }
    
    // Fourth return the remaining edges which do conform with the specification
    return [edges allObjects];
    
} // findEdgesWithSourceVertices()

- (NSArray *)findEdgesWithTargetVertex:(Vertex *)target
{
    
    NSArray *targetArray = [NSArray arrayWithObject:target];
    
    return [self findEdgesWithTargetVertices:targetArray];
    
} // findEdgesWithTargetVertex()


- (NSArray *)findEdgesWithTargetVertices:(NSArray *)target
{
    
    if (target == nil) {
        return nil;
    }    
    if ([target count] == 0) {
        return nil;
    }
    
    // First get all edges
    NSMutableSet *edges = [NSMutableSet setWithArray:[self getEdges]];
    
    // Second intersect each source vertex's set of edges with set of all edges to get edges with source vertices at least
    for (Vertex *v in target) {
        [edges intersectSet:[_vertices objectForKey:v]];
    }
    
    // Third verify that remaining edges' source vertices sets correspond with vertices' set parameter
    if ([edges count] != 0) {
        for (DirectedHyperEdge *e in edges) {
            // Note that we validate that vertices set parameter is equal to each remaining target edge's vertices set                        
            if (![e countTargetVertices] == [target count] || ![e hasTargetWithVertices:target]) {
                // Remove the current edge because its source vertices set is not equal to the parameter
                [edges removeObject:e];
            }
        }
    }
    
    // Fourth return the remaining edges which do conform with the specification
    return [edges allObjects];
    
} // findEdgesWithTargetVertices()

- (NSArray *)findEdgesWithSourceVertex:(Vertex *)source withTargetVertex:(Vertex *)target
{
    
    NSArray *sourceArray = [NSArray arrayWithObject:source];
    NSArray *targetArray = [NSArray arrayWithObject:target];    
    
    return [self findEdgesWithSourceVertices:sourceArray withTargetVertices:targetArray];        
    
} // findEdgesWithSourceVertex()

- (NSArray *)findEdgesWithSourceVertex:(Vertex *)source withTargetVertices:(NSArray *)target
{
    
    NSArray *sourceArray = [NSArray arrayWithObject:source];
    
    return [self findEdgesWithSourceVertices:sourceArray withTargetVertices:target];    
    
} // findEdgesWithSourceVertex()

- (NSArray *)findEdgesWithSourceVertices:(NSArray *)source withTargetVertex:(Vertex *)target
{
    
    NSArray *targetArray = [NSArray arrayWithObject:target];
    
    return [self findEdgesWithSourceVertices:source withTargetVertices:targetArray];
    
} // findEdgesWithSourceVertices()

- (NSArray *)findEdgesWithSourceVertices:(NSArray *)source withTargetVertices:(NSArray *)target
{
    
    NSArray *edgesWithSourceVertices = [self findEdgesWithSourceVertices:source];
    NSArray *edgesWithTargetVertices = [self findEdgesWithTargetVertices:target];
    
    if (edgesWithSourceVertices == nil || edgesWithTargetVertices == nil) {
        return nil;
    }
    
    // TODO: Do I really need this? If there are no edges with defined source or target, then the result should be empty too... right? In the end, nil is used for errors and bad use
    /*
     if ([edgesWithSourceVertices count] == 0 || [edgesWithTargetVertices count] == 0) {
     return nil;
     }
     */
    
    NSMutableSet *edgesWithSourceVerticesSet = [NSSet setWithArray:edgesWithSourceVertices];
    NSMutableSet *edgesWithTargetVerticesSet = [NSSet setWithArray:edgesWithTargetVertices];    
    
    [edgesWithSourceVerticesSet intersectSet:edgesWithTargetVerticesSet];
    
    return [edgesWithSourceVerticesSet allObjects];
    
} // findEdgesWithSourceVertices()

- (BOOL)isFHyperGraph
{
    
    NSArray *edges = [self getEdges];
    
    for (DirectedHyperEdge *e in edges) {
        if ( [e countSourceVertices] != 1 ) {
            return FALSE;
        }
    }
            
    return TRUE;
    
} // isFHyperGraph()

- (BOOL)isBHyperGraph
{

    NSArray *edges = [self getEdges];
    
    for (DirectedHyperEdge *e in edges) {
        if ( [e countTargetVertices] != 1 ) {
            return FALSE;
        }
    }

    return TRUE;
    
} // isBHyperGraph()

#pragma mark - HyperEdge protocol overriden implementation

- (HyperEdge *)addEdgeFromVertex:(Vertex *)vertex
{
    
    @throw [NSException exceptionWithName:@"OperationNotAllowedException" reason:@"Method usage not allowed" userInfo:nil];
    
} // addEdgeFromVertex()

- (HyperEdge *)addEdgeFromVertices:(NSArray *)vertices
{
    
    @throw [NSException exceptionWithName:@"OperationNotAllowedException" reason:@"Method usage not allowed" userInfo:nil];
    
} // addEdgeFromVertices()

- (BOOL)areAdjacent:(NSArray *)vertices
{

    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Not yet implemented" userInfo:nil];    
    
} // areAdjacent()

- (NSArray *)getAdjacentToVertex:(Vertex *)vertex
{
    
    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Not yet implemented" userInfo:nil];    

} // getAdjacentToVertex()

- (NSArray *)getAdjacentToVertices:(NSArray *)vertices
{
    
    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Not yet implemented" userInfo:nil];    

} // getAdjacentToVertices()

@end
