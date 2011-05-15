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

    if (source == nil && target == nil) {
        return nil;
    }
    
    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Not yet implemented" userInfo:nil];
    
}

- (DirectedHyperEdge *)addEdgeWithSourceVertex:(Vertex *)source withTargetVertices:(NSArray *)target
{

    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Not yet implemented" userInfo:nil];

}

- (DirectedHyperEdge *)addEdgeWithSourceVertices:(NSArray *)source withTargetVertices:(NSArray *)target
{
    
    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Not yet implemented" userInfo:nil];
    
}

- (DirectedHyperEdge *)addEdgeWithSourceVertices:(NSArray *)source withTargetVertex:(Vertex *)target
{
    
    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Not yet implemented" userInfo:nil];    

}

@end
