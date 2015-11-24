//
//  NoteListViewController.m
//  my note
//
//  Created by Greg Xu on 2/24/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import "NoteListViewController.h"
#import "AppDelegate.h"
#import "NoteItemViewController.h"
#import "Note.h"
#import "NoteTableViewCell.h"

@interface NoteListViewController ()

@property (strong, nonatomic)NSArray *notes;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic)NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation NoteListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    self.notes = [self.context executeFetchRequest:fetchRequest error:&error];
    [self.tableView reloadData];
}

- (void)loadInitialData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.notes = [self.context executeFetchRequest:fetchRequest error:&error];
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.notes count]];
}

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
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = delegate.managedObjectContext;
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + self.searchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
    [self loadInitialData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    } else {
        return [self.notes count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NoteTableViewCell";
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NoteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Note *note = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        note = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        note = [self.notes objectAtIndex:indexPath.row];
    }
    cell.nameLabel.text = note.content;
    cell.previewLabel.text = note.content;
    
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

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.context deleteObject:[self.notes objectAtIndex:indexPath.row]];
        
        NSError *error;
        if (![self.context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
        }

        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.context];
        [fetchRequest setEntity:entity];
        
        self.notes = [self.context executeFetchRequest:fetchRequest error:&error];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier: @"ShowNoteContent" sender: self];
    }
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"ShowNoteContent"]) {
        NoteItemViewController *noteItemViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Note *note = nil;
        
        if (self.searchDisplayController.isActive) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            note = [self.searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            note = [self.notes objectAtIndex:indexPath.row];
        }
        
        noteItemViewController.note = note;
    }
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
    [self.searchResults removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.content contains[c] %@",searchText];
    self.searchResults = [NSMutableArray arrayWithArray:[self.notes filteredArrayUsingPredicate:resultPredicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
}

@end
