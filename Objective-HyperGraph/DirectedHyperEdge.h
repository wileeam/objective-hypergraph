/*
 * DirectedHyperEdge.h
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


#import <Foundation/Foundation.h>

#import "NSString+UUID.h"
#import "DirectedHyperEdgeProtocol.h"

#import "Vertex.h"
#import "HyperEdge.h"


/*
 * Simple directed link/edge representation class
 *
 * If not inheriting from this class, implementing the protocol should be
 * mandatory
 */
@interface DirectedHyperEdge : HyperEdge <DirectedHyperEdgeProtocol, NSCopying> {

    /*
     * Set of hyper-edge source vertices
     *
     * TODO: Array, Set? Which one is better? Does it matter?
     */
    NSMutableSet *_source;
    
    /*
     * Set of hyper-edge target vertices
     *
     * TODO: Array, Set? Which one is better? Does it matter?
     */    
    NSMutableSet *_target;

} //DirectedHyperEdge{}

#pragma mark - Initialiasing methods
- (id)initWithSourceVertex:(Vertex *)vertex;
- (id)initWithSourceVertices:(NSArray *)vertices;
- (id)initWithTargetVertex:(Vertex *)vertex;
- (id)initWithTargetVertices:(NSArray *)vertices;
- (id)initWithSourceAndTargetVertex:(Vertex *)source:(Vertex *)target;
- (id)initWithSourceAndTargetVertices:(NSArray *)source:(NSArray *)target;
- (id)initWithSourceVertexAndTargetVertices:(Vertex *)source:(NSArray *)target;
- (id)initWithSourceVerticesAndTargetVertex:(NSArray *)source:(Vertex *)target;

@end
