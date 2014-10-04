var database;

database = angular.module('ngDatabase', Array);

database.factory('$database', Array(function() {
  var Database;
  return new (Database = (function() {
    function Database() {}

    Database.prototype.sql = {};

    Database.prototype.createTable = function() {};

    Database.prototype.select = function(param) {
      if (typeof param === 'undefined') {
        param = ['*'];
      }
      this.sql['SELECT'] = param;
      return this;
    };

    Database.prototype.insert = function() {
      return this;
    };

    Database.prototype.update = function() {
      return this;
    };

    Database.prototype.where = function(field, value, operator) {
      if (typeof operator === 'undefined') {
        operator = '=';
      }
      this.sql['WHERE'] = field + ' ' + operator + ' \'' + value + '\'';
      return this;
    };

    Database.prototype.from = function(param) {
      this.sql['FROM'] = param;
      return this;
    };

    Database.prototype.exec = function() {};

    return Database;

  })());
}));
