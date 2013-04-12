//
//  Conexao.h
//  Cavaleiros
//
//  Created by Sonia Ribeiro on 11/04/13.
//  Copyright (c) 2013 iLearn Educação e Informática Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConexaoDelegate.h"

@interface Conexao : NSObject <NSURLConnectionDataDelegate> {
    NSMutableData * receivedData;
}

@property (weak) id <ConexaoDelegate> delegate;

- (void) iniciarComURL:(NSString *)url;

@end
