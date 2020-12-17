//
//  DBHelper.swift
//  TestApp
//
//  Created by Jyoti Mitkar on 24/11/20.
//

import Foundation
import SQLite3

class DBHelper {
    
    var db:OpaquePointer?
    let dbPath: String = "Chat.sqlite"
    
    init(){
        
        db = openDatabase()
        createTable()
    }
    
    
    /* To check whether Chat.sqlite database exists or not. If database exist, this method simply return database pointer.
     If it doesn't exist, it will create database first. After that it will return database pointer */
    func openDatabase() -> OpaquePointer? {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        
        print("DATABASE PATH =============> \(fileURL)")
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        
        let createTableString = "CREATE TABLE IF NOT EXISTS users(Id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,password TEXT, username TEXT);"
        
        var createTableStatement: OpaquePointer? = nil
        
        //Converts String formatted query into byte format
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            //Execute create table query into the database
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("users table created.")
            } else {
                print("users table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement) //removing createTableStatement object from the memory to prevent memory leak
    }
    
    //Inserting data in the form of model into the database
    func insert(user: User) -> Bool
    {
        let insertStatementString = "INSERT INTO users (name, password, username) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, (user.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (user.password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (user.username as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                sqlite3_finalize(insertStatement)
                return true
            } else {
                print("Could not insert row.")
                sqlite3_finalize(insertStatement)
                return false
            }
            
        } else {
            print("INSERT statement could not be prepared.")
            sqlite3_finalize(insertStatement)
            return false
        }
    }
    
    //Fetching/Retrieving data from the database
    func getUserDetails() -> [User] {
        
        let queryStatementString = "SELECT * FROM users;"
        var queryStatement: OpaquePointer? = nil
        var user : [User] = [] //Array of user
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                let userDetails = User(name: name, username: username, password: password)
                user.append(userDetails)
                
                print("getUserDetails QUAERY RESULT : \n")
                print("ID :======================== \(id)")
                print("NAME :======================== \(name)")
                print("USERNAME :======================== \(username)")
                print("PASSWORD :======================== \(password)")

            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        
        return user
    }
    
    //Fetching/Retrieving data from the database
    func authenticateUserWith(userName: String, userPassword: String) -> User? {
        
        let queryStatementString = "SELECT * from users where username = ? and password = ?"
        
        var queryStatement: OpaquePointer? = nil
        var user:User? = nil //Optional

        //sqlite3_prepare_v2 :========= Converts String query into byte format
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(queryStatement, 1, (userName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (userPassword as NSString).utf8String, -1, nil)
            
            // sqlite3_step : Used to execute insert, select and CREATE table query
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
               // let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                user = User(name: name, username: username, password: password)
            }
            
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        
        if let userDetails = user {
            
            print("authenticateUserWith QUAERY RESULT : \n")
            print("NAME :======================== \(userDetails.name)")
            print("USERNAME :======================== \(userDetails.username)")
            print("PASSWORD :======================== \(userDetails.password)")
            
            return userDetails
        }
        
        return nil
        
    }
    
    
    func updateWith(name: String, userName: String) -> Bool {
        
        let queryStatementString = "UPDATE users SET name = ? WHERE username = ?"
        var queryStatement: OpaquePointer? = nil

        //sqlite3_prepare_v2 :========= Converts String query into byte format
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(queryStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (userName as NSString).utf8String, -1, nil)

            // sqlite3_step : Used to execute insert, select, update and CREATE table query
            if sqlite3_step(queryStatement) == SQLITE_DONE {
                
                sqlite3_finalize(queryStatement)
                return true
            }
            
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return false
        
    }
}
