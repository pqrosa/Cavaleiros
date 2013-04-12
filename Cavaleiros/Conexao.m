//
//  Conexao.m
//  Cavaleiros
//
//  Created by Sonia Ribeiro on 11/04/13.
//  Copyright (c) 2013 iLearn Educação e Informática Ltda. All rights reserved.
//

#import "Conexao.h"
#import "Cavaleiro.h"

@implementation Conexao

@synthesize delegate;

- (void) iniciarComURL:(NSString *)url {

    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:60.0];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
    }
}

#pragma mark - NSURLConnectionDataDelegate metodos

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    // faço o parser do conteúdo na variável receivedData
    NSError *erro = nil;
    NSDictionary *dicionario = [NSJSONSerialization JSONObjectWithData:receivedData 
                                                               options:NSJSONReadingAllowFragments 
                                                                 error:&erro];
    
    // crio o dicionario que irei retornar, de acordo com a capacidade do dicionário do 'parser'
    NSMutableDictionary *dicionarioCavaleiros = [NSMutableDictionary dictionaryWithCapacity:[dicionario count]];
    
    // pego as chaves do dicionario e itero sobre elas
    for (NSString *chave in [dicionario allKeys])
    {
        NSArray *cavaleirosArray = [dicionario objectForKey:chave];
        NSMutableArray *cavaleiros = [NSMutableArray arrayWithCapacity:[cavaleirosArray count]];
        
        // iterno sobre os dicionários de cavaleiros
        for (NSDictionary *cavaleiroDicionario in cavaleirosArray) {
            Cavaleiro *umCavaleiro = [[Cavaleiro alloc] init];
            umCavaleiro.nome = [cavaleiroDicionario objectForKey:@"cavaleiro"];
            umCavaleiro.signo = [cavaleiroDicionario objectForKey:@"signo"];
            umCavaleiro.armadura = [cavaleiroDicionario objectForKey:@"imagem"];
            
            [cavaleiros addObject:umCavaleiro]; 
        }
        
        [dicionarioCavaleiros setObject:cavaleiros forKey:chave];
        
    }
    
    if (self.delegate) {
        [self.delegate termineiComSucesso:dicionarioCavaleiros];
    }
    
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
}

@end
