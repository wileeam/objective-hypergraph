//
//  HyperGraph.m
//  Keiko
//
//  Created by Guillermo on 19/04/11.
//  Copyright 2011 Guillermo Rodríguez Cano. All rights reserved.
//

#import "HyperGraph.h"

#import "NSString+UUID.h"

@implementation HyperGraph

- (id)init
{
    
    // Parent initialisation's check and adjacent matrix's population
	if ((self = [super init]) != nil) {
        _uuid = [NSString stringWithUUID];
    }
    
    return self;
    
} // init()

- (void)dealloc
{
    
    [_uuid dealloc];
    
    [super dealloc];
    
} // dealloc()

#pragma mark - 

- (HyperEdge *)addEdgeFromVertex:(Vertex *)vertex
{
    return [HyperEdge new];
}

- (HyperEdge *)addEdgeFromVertices:(NSArray *)vertices
{
    return [HyperEdge new];
}

- (Vertex *)addVertex:(Vertex *)vertex
{
    return [Vertex new];
}

- (NSArray *)addVertices:(NSArray *)vertices
{
    return [NSArray new];
}

- (HyperEdge *)removeEdge:(HyperEdge *)edge
{
    return [HyperEdge new];
}

- (NSArray *)removeEdges:(NSArray *)edges
{
    return [NSArray new];
}

- (Vertex *)removeVertex:(Vertex *)vertex
{
    return [Vertex new];
}

- (NSArray *)removeVertices:(NSArray *)vertices
{
    return [NSArray new];
}

- (NSArray *)getAllEdges
{
    return [NSArray new];    
}

- (NSArray *)getEdgesConnectingVertex:(Vertex *)vertex
{
    return [NSArray new];    
}

- (NSArray *)getEdgesConnectingVertices:(NSArray *)vertices
{
    return [NSArray new];    
}

- (BOOL)containsVertex:(Vertex *)vertex
{
    return false;
}

- (BOOL)containsEdge:(HyperEdge *)edge
{
    return false;
}

- (NSArray *)getConnectedVertices
{
    return [NSArray new];    
}

- (NSArray *)getDisconnectedVertices
{
    return [NSArray new];    
}

- (BOOL)areAdjacent:(NSArray *)vertices
{
    return false;
}

- (NSArray *)getAdjacent:(Vertex *)vertex
{
    return [NSArray new];    
}

- (NSUInteger *)countVertices
{
    return 0;
}
- (NSUInteger *)countEdges
{
    return 0;
}

- (BOOL)isMultiGraph
{
    return false;
}

@end
