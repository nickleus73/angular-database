var database;

database = angular.module('ngDatabase', Array);

database.factory('$database', Array(function() {
  var Database;
  return new (Database = (function() {
    function Database() {}

    Database.prototype.sql = null;

    Database.prototype.createTable = function() {};

    Database.prototype.select = function() {};

    Database.prototype.insert = function() {};

    Database.prototype.update = function() {};

    Database.prototype.where = function() {};

    return Database;

  })());
}));
