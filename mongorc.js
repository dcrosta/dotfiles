prompt = function() {
  var serverStatus = db.runCommand({serverStatus: 1});

  var hostname = serverStatus.host;
  if (!/\d+\.\d+\.\d+\.\d+/.test(hostname) && /\./.test(hostname))
    hostname = hostname.substr(0, hostname.indexOf('.'));

  if (serverStatus.process != "mongod") {
    return serverStatus.process + '@' + hostname + ':' + db + '> ';
  } else {
    var states = ["startup", "primary", "secondary", "recovering", "fatal", "startup2", "unknown", "arbiter", "down", "rollback"];
    var rsstatus = db.adminCommand({replSetGetStatus: 1});

    if (rsstatus.ok == 0) {
      return hostname + ':' + db + '> ';
    } else {
      return states[rsstatus.myState] + '@' + hostname + ':' + db + '> ';
    }
  }
}

