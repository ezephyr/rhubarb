#!/usr/bin/env ruby

require('trollop')
require('mysql')

opts = Trollop::options do
    opt :db_location,   "Databse server location",  :short=> 'l', :default=> 'localhost'
    opt :db_user,       "Database User",            :short=> 'u', :default=> 'root'
    opt :db_password,   "Database Password",        :short=> 'p', :defualt=> '', :type=> String
    opt :db_database,   "Database Name",            :short=> 'n', :default=> 'rhubarb'
    #opt :db_prefix,     "Database Prefix",          :short=> 'r', :default=> '', :type=> String
end

p "Attempting to create tables in database '" + opts[:db_database] +"' at host '" + opts[:db_location] + "' as user '" + opts[:db_user] + "...'"

File.open('db_connection.rb','w') { |file| file.write("$hostname = \"" + opts[:db_location].to_s + "\"\n$database = \"" + opts[:db_database].to_s + "\"\n$username = \"" + opts[:db_user].to_s + "\"\n$password = \"" + opts[:db_password].to_s + "\"")} 

#THIS
create_rhubarb_games = "CREATE TABLE rhubarb_games (id int(11) NOT NULL AUTO_INCREMENT,winner int(11) NOT NULL,loser int(11) NOT NULL,winner_score int(11) NOT NULL,loser_score int(11) NOT NULL,timestamp time NOT NULL,PRIMARY KEY (id)) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;"

#IS
create_rhubarb_pending_games = "CREATE TABLE rhubarb_pending_games (id int(11) NOT NULL AUTO_INCREMENT,sender_id int(11) NOT NULL,recipient_id int(11) NOT NULL,winner int(11) NOT NULL,loser int(11) NOT NULL,winner_score int(11) NOT NULL,loser_score int(11) NOT NULL,timestamp time NOT NULL,PRIMARY KEY (id)) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;"

#UGLY
create_rhubarb_players = "CREATE TABLE rhubarb_players (id int(11) NOT NULL,name varchar(50) NOT NULL,username varchar(50) NOT NULL,password varchar(200) NOT NULL,rating_package varchar(200) DEFAULT NULL,rating double DEFAULT NULL,PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=latin1;" 

#Create a connection to the database with the supplied information
con = Mysql.new(opts[:db_location], opts[:db_user], opts[:db_password], opts[:db_database])

#Create tables in database
con.query(create_rhubarb_games)
p "Successfully created table rhubarb_games in database '" + opts[:db_database] + "'."
con.query(create_rhubarb_pending_games)
p "Successfully created table rhubarb_pending_games in database '" + opts[:db_database] + "'."
con.query(create_rhubarb_players)
p "Successfully created table rhubarb_players in database '" + opts[:db_database] + "'."
