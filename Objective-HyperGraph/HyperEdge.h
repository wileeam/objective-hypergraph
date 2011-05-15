/*
 * HyperEdge.h
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
#import "HyperEdgeProtocol.h"


/*
 * Simple unidrected link/edge representation class
 *
 * If not inheriting from this class, implementing the protocol should be
 * mandatory
 */
@interface HyperEdge : NSObject <HyperEdgeProtocol, NSCopying> {
    
    /*
     * Simple UUID (GUID) string attribute
     */    
    NSString *_uuid;
    
    /*
     * An undirected hyper-edge is a set of vertices
     *
     * TODO: Array, Set? Which one is better? Does it matter?
     */
    NSMutableSet *_vertices;
    
} // HyperEdge{}

#pragma mark - Properties
// Short identifying name attribute
@property (nonatomic, retain) NSString *name;

#pragma mark - Initialiasing methods
- (id)initWithVertex:(Vertex *)vertex;
- (id)initWithVertices:(NSArray *)vertices;

#pragma mark - Custom methods (testing this instead of a readonly property)
- (NSString *)getUUID;

@end
