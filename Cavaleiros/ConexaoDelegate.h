//
//  ConexaoDelegate.h
//  Cavaleiros
//
//  Created by Sonia Ribeiro on 11/04/13.
//  Copyright (c) 2013 iLearn Educação e Informática Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConexaoDelegate <NSObject>

- (void) termineiComSucesso:(NSDictionary *) retornoDaConexao;
- (void) erroNaConexao;

@end
