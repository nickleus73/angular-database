var SQLAdapter;

SQLAdapter = (function() {
  SQLAdapter.prototype.db = null;

  SQLAdapter.prototype.stmt = null;

  function SQLAdapter() {
    this.db = new SQL.Database();
    return;
  }

  SQLAdapter.prototype.openDatabase = function() {};

  SQLAdapter.prototype.exec = function(sql) {
    return this.db.exec(sql);
  };

  SQLAdapter.prototype.prepare = function(sql) {
    this.stmt = this.db.prepare(sql);
    return this;
  };

  SQLAdapter.prototype.getResult = function() {
    var rows;
    rows = [];
    while (this.stmt.step()) {
      rows.push(this.stmt.getAsObject());
    }
    return rows;
  };

  return SQLAdapter;

})();
