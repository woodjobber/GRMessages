
//
//  SaveImage.m
//  GRUC
//
//  Created by chengbin on 16/1/21.
//
//

#import "SaveImage.h"
#import <sqlite3.h>
@interface SaveImage()
@property (nonatomic) sqlite3 *db;
@end;

@implementation SaveImage
@synthesize db;

-(instancetype)init{
    if (self = [super init]) {
        db =[self openDB];
        [self createImageTable];
    }
    return self;
}

- (NSString *)databasePath{
    NSArray *nibs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [nibs lastObject];
    NSString *path = [dir stringByAppendingPathComponent:@"image.sqlite"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
      [[NSFileManager defaultManager]createFileAtPath:path contents:nil attributes:nil];
     
    }
    return path;
}
- (sqlite3 *)openDB{
     sqlite3 *_db = NULL;
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self databasePath]]) {
       
        NSString *path = [self databasePath];
        
        if (sqlite3_open_v2([path UTF8String], &_db,SQLITE_OPEN_CREATE|SQLITE_OPEN_READWRITE, NULL) != SQLITE_OK) {
            NSLog(@"%s",sqlite3_errmsg(_db));
        }
    }
  
    return _db;
}
- (void)createImageTable{
    
  char *errmsg = NULL;

    NSString *str = [NSString stringWithFormat:@"create table if not exists IMAGES (pid integer primary key autoincrement not null,NAME text unique,IMAGE blob)"];
    if (sqlite3_exec(db, str.UTF8String, NULL, NULL, &errmsg) !=SQLITE_OK) {
        NSLog(@"Fail to create \"IMAGES\" table.Error is :%s",errmsg);
        NSLog(@"%s",sqlite3_errmsg(db));
    }
}

- (void)saveImagesToSql:(NSData *)imgData withimageName:(NSString *)name{
    const char *sqlQuery = "INSERT INTO IMAGES(NAME,IMAGE) VALUES (?,?)";
    sqlite3_stmt *statement = NULL;
    if (sqlite3_prepare_v2(db, sqlQuery, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_blob(statement, 2, [imgData bytes], (int)[imgData length], SQLITE_TRANSIENT);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            
        }
    }else{
        NSLog(@"SaveBody:Failed from sqlite3_prepare_v2,Error is :%s",sqlite3_errmsg(db));
    }
   
    sqlite3_finalize(statement);
}

- (NSData *)loadImagesFromSql:(NSString *)imageName{
    NSData *data = nil;
    sqlite3_stmt *statement;
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT IMAGE FROM IMAGES WHERE NAME = '%@'",imageName];
    if (sqlite3_prepare_v2(db, sqlQuery.UTF8String, -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            int length = sqlite3_column_bytes(statement, 0);
            data = [NSData dataWithBytes:sqlite3_column_blob(statement, 0) length:length];
        }
    }else{
       NSLog(@"%s",sqlite3_errmsg(db));
    }
    sqlite3_finalize(statement);
    return data;
}
@end
