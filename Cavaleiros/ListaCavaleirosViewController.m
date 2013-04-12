//
//  ListaCavaleirosViewController.m
//  Cavaleiros
//
//  Created by Sonia Ribeiro on 11/04/13.
//  Copyright (c) 2013 iLearn Educação e Informática Ltda. All rights reserved.
//

#import "ListaCavaleirosViewController.h"
#import "Conexao.h"
#import "Cavaleiro.h"

@interface ListaCavaleirosViewController () {
    NSArray *cavaleirosDeOuro, *cavaleirosDeBronze;
    Conexao *conexao;
}

@end

@implementation ListaCavaleirosViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (!cavaleirosDeOuro || !cavaleirosDeBronze) {
        [self baixaDadosCavaleiros];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *cavaleiros = [self arrayCavaleirosParaSection:section];
    return [cavaleiros count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] init]; //[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSArray *cavaleiros = [self arrayCavaleirosParaSection:indexPath.section];
    Cavaleiro *umCavaleiro = [cavaleiros objectAtIndex:indexPath.row];
    
    cell.textLabel.text = umCavaleiro.nome;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Privados

- (void)baixaDadosCavaleiros {
    if (!conexao) {
        conexao = [[Conexao alloc] init];
        conexao.delegate = self;
    }    
    [conexao iniciarComURL:@"http://www.mobits.com.br/fsvas/CDZ/cavaleiros.json"];
}

- (NSArray *)arrayCavaleirosParaSection:(NSInteger)section
{
    if(section) {
        return cavaleirosDeBronze;
    }
    else {
        return cavaleirosDeOuro;
    }
}

#pragma mark - métodos ConexaoDelegate

- (void)termineiComSucesso:(NSDictionary *)retornoDaConexao
{
    cavaleirosDeBronze = [retornoDaConexao objectForKey:@"bronze"];
    cavaleirosDeOuro = [retornoDaConexao objectForKey:@"ouro"];
    
    [self.tableView reloadData];
}

- (void) erroNaConexao
{
    NSLog(@"Erro!");
}

@end
