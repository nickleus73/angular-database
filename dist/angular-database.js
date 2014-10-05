var database;

database = angular.module('ngDatabase', Array);

database.factory('$database', Array(function() {
  var Database;
  return new (Database = (function() {
    function Database() {}

    Database.prototype.sql = {};

    Database.prototype.req = null;

    Database.prototype.order_command = ['INSERT', 'UPDATE', 'SELECT', 'FROM', 'WHERE', 'AND WHERE', 'OR WHERE'];

    Database.prototype.createTable = function() {};

    Database.prototype.select = function(param) {
      if (typeof param === 'undefined') {
        param = ['*'];
      }
      this.sql['SELECT'] = param;
      return this;
    };

    Database.prototype.insert = function(table, cols, values) {
      this.sql['INSERT'] = {
        'TABLE': table,
        'PARAMS': {
          'COLS': cols,
          'VALUES': values
        }
      };
      return this;
    };

    Database.prototype.update = function(table, params) {
      var array, field, param, value, _i, _len;
      array = [];
      for (_i = 0, _len = params.length; _i < _len; _i++) {
        param = params[_i];
        for (field in param) {
          value = param[field];
          array.push(field + ' = \'' + value + '\'');
        }
      }
      this.sql['UPDATE'] = {
        'TABLE': table,
        'PARAMS': array
      };
      return this;
    };

    Database.prototype.where = function(field, value, operator) {
      if (typeof operator === 'undefined') {
        operator = '=';
      }
      this.sql['WHERE'] = field + ' ' + operator + ' \'' + value + '\'';
      return this;
    };

    Database.prototype.andWhere = function(field, value, operator) {
      if (typeof operator === 'undefined') {
        operator = '=';
      }
      if (typeof this.sql['AND WHERE'] === 'undefined') {
        this.sql['AND WHERE'] = [];
      }
      this.sql['AND WHERE'].push(field + ' ' + operator + ' \'' + value + '\'');
      return this;
    };

    Database.prototype.orWhere = function(field, value, operator) {
      if (typeof operator === 'undefined') {
        operator = '=';
      }
      if (typeof this.sql['OR WHERE'] === 'undefined') {
        this.sql['OR WHERE'] = [];
      }
      this.sql['OR WHERE'].push(field + ' ' + operator + ' \'' + value + '\'');
      return this;
    };

    Database.prototype.from = function(param) {
      this.sql['FROM'] = param;
      return this;
    };

    Database.prototype.exec = function() {
      var order, _i, _len, _ref;
      this.req = '';
      _ref = this.order_command;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        order = _ref[_i];
        switch (order) {
          case 'SELECT':
            this._select();
            break;
          case 'FROM':
            this._from();
            break;
          case 'WHERE':
            this._where();
            break;
          case 'INSERT':
            this._insert();
            break;
          case 'UPDATE':
            this._update();
        }
      }
      this.req += ';';
    };

    Database.prototype._select = function() {
      if (typeof this.sql['SELECT'] === 'undefined') {
        return;
      }
      this.req = '';
      this.req = 'SELECT ' + this.sql['SELECT'].join(', ');
    };

    Database.prototype._from = function() {
      if (typeof this.sql['FROM'] === 'undefined') {
        return;
      }
      this.req += ' FROM `' + this.sql['FROM'] + '`';
    };

    Database.prototype._where = function() {
      if (typeof this.sql['WHERE'] === 'undefined') {
        return;
      }
      this.req += ' WHERE ' + this.sql['WHERE'];
    };

    Database.prototype._insert = function() {
      var fields, i, insert, val, values, _i, _len, _ref;
      if (typeof this.sql['INSERT'] === 'undefined') {
        return;
      }
      insert = this.sql['INSERT'];
      fields = insert['PARAMS']['COLS'].join(', ');
      _ref = insert['PARAMS']['VALUES'];
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        val = _ref[i];
        insert['PARAMS']['VALUES'][i] = "'" + val + "'";
      }
      values = insert['PARAMS']['VALUES'].join(', ');
      this.req += "INSERT INTO `" + insert['TABLE'] + "` (" + fields + ") VALUES (" + values + ")";
    };

    Database.prototype._update = function() {
      var params, update;
      if (typeof this.sql['UPDATE'] === 'undefined') {
        return;
      }
      update = this.sql['UPDATE'];
      params = update['PARAMS'].join(', ');
      this.req += "UPDATE `" + update['TABLE'] + "` SET " + params;
    };

    return Database;

  })());
}));
