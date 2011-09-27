/*
 * BHyperGraph.m
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


#import "BHyperGraph.h"


@implementation BHyperGraph

- (DirectedHyperEdge *)addEdgeWithSourceVertex:(Vertex *)source withTargetVertex:(Vertex *)target
{
    return [super addEdgeWithSourceVertex:source withTargetVertex:target];
}

// TODO: This is somewhat allowed, although pointless because target array must have a size of one
- (DirectedHyperEdge *)addEdgeWithSourceVertex:(Vertex *)source withTargetVertices:(NSArray *)target
{
    
    if (target == nil) {
        return nil;
    }
    if ([target count] != 1) {
        return nil;
    }
    
    return [super addEdgeWithSourceVertex:source withTargetVertices:target];    
}

- (DirectedHyperEdge *)addEdgeWithSourceVertices:(NSArray *)source withTargetVertex:(Vertex *)target
{
    
    return [super addEdgeWithSourceVertex:[source objectAtIndex:0] withTargetVertex:target];
    
} // addEdgeWithSourceVertices()

// TODO: This is somewhat allowed, although pointless because source array must have a size of one
- (DirectedHyperEdge *)addEdgeWithSourceVertices:(NSArray *)source withTargetVertices:(NSArray *)target
{
    
    if (source == nil) {
        return nil;
    }
    if ([source count] != 1) {
        return nil;
    }
    
    return [super addEdgeWithSourceVertex:[source objectAtIndex:0] withTargetVertices:target];    
    
} // addEdgeWithSourceVertices()


@end
