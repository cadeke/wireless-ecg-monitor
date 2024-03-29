import { InfluxDB } from "@influxdata/influxdb-client";
import express from "express";

const app = express();

const url = "http://192.168.1.101:8086"; // change this to the IP of the InfluxDB instance (usually it's http://localhost:8086)
const org = "intproject"; // change this to the name of your organisation
const token =
  "lpdGK1n0Mdce9t9auJ9nvPH4YSDSlnFLGTUESkxe6HosLjHGIsadzakVhHgTtPHOGqRMwHqdgqHWHv0SFPblpg=="; // change this to the token of your bucket

const queryApi = new InfluxDB({ url, token }).getQueryApi(org);

const bucket = "ecgdb";
const measurementName = "heart_rate";
const fieldVoltageName = "ecgValue";
const fieldTimestampName = "timeValue";
const fieldBpmName = "bpm";

const shortQuery = "30s";
const mediumQuery = "1m";
const longQuery = "2m";

let data = [];

function showInfo(req){
  console.log(`Route "${req.url}" was requested by "${req.header('x-forwarded-for') || req.connection.remoteAddress.substr(7)}"`);
}

// Default route
app.get("/", (req, res) => {
  showInfo(req);
  res.send("Everything works!");
});

// Short list of data
app.get("/ecg/short", (req, res) => {
  // Query for 30s of data
  let t1 =
  `from(bucket: "${bucket}") |> range(start: -${shortQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldVoltageName}")`;
  let t2 =
  `from(bucket: "${bucket}") |> range(start: -${shortQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldTimestampName}")`;

  let fluxQuery = `join(tables: {voltage: ${t1}, timestamp: ${t2}}, on: ["_time"])`;

  showInfo(req);
  let myPromise = new Promise(function (myResolve, myReject) {
    data.length = 0; // clear array
    queryApi.queryRows(fluxQuery, {
      next(row, tableMeta) {
        const o = tableMeta.toObject(row);
        data.push(o);
      },
      error(error) {
        console.error(error);
        console.log("\nFinished ERROR");
        myReject("Error");
      },
      complete() {
        console.log("\nFinished gettingData SUCCESS");
        myResolve(data);
      },
    });
  });

  myPromise.then(
    function (value) {
      res.send(value); // determine content-type automatically
    },
    function (error) {
      console.log(error);
    }
  );
});

// Medium list of data
app.get("/ecg/medium", (req, res) => {
  // Query for 1 minute of data
  let t1 =
  `from(bucket: "${bucket}") |> range(start: -${mediumQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldVoltageName}")`;
  let t2 =
  `from(bucket: "${bucket}") |> range(start: -${mediumQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldTimestampName}")`;

  let fluxQuery = `join(tables: {voltage: ${t1}, timestamp: ${t2}}, on: ["_time"])`;

  showInfo(req);
  let myPromise = new Promise(function (myResolve, myReject) {
    data.length = 0; // clear array
    queryApi.queryRows(fluxQuery, {
      next(row, tableMeta) {
        const o = tableMeta.toObject(row);
        data.push(o);
      },
      error(error) {
        console.error(error);
        console.log("\nFinished ERROR");
        myReject("Error");
      },
      complete() {
        console.log("\nFinished gettingData SUCCESS");
        myResolve(data);
      },
    });
  });

  myPromise.then(
    function (value) {
      res.send(value); // determine content-type automatically
    },
    function (error) {
      console.log(error);
    }
  );
});

// Long list of data
app.get("/ecg/long", (req, res) => {
  // Query for 2 minutes of data
  let t1 =
  `from(bucket: "${bucket}") |> range(start: -${longQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldVoltageName}")`;
  let t2 =
  `from(bucket: "${bucket}") |> range(start: -${longQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldTimestampName}")`;

  let fluxQuery = `join(tables: {voltage: ${t1}, timestamp: ${t2}}, on: ["_time"])`;

  showInfo(req);
  let myPromise = new Promise(function (myResolve, myReject) {
    data.length = 0; // clear array
    queryApi.queryRows(fluxQuery, {
      next(row, tableMeta) {
        const o = tableMeta.toObject(row);
        data.push(o);
      },
      error(error) {
        console.error(error);
        console.log("\nFinished ERROR");
        myReject("Error");
      },
      complete() {
        console.log("\nFinished gettingData SUCCESS");
        myResolve(data);
      },
    });
  });

  myPromise.then(
    function (value) {
      res.send(value); // determine content-type automatically
    },
    function (error) {
      console.log(error);
    }
  );
});

// Short list of data
app.get("/bpm/short", (req, res) => {
  // Query for 30s of data
  let t1 =
  `from(bucket: "${bucket}") |> range(start: -${shortQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldBpmName}")`;
  let t2 =
  `from(bucket: "${bucket}") |> range(start: -${shortQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldTimestampName}")`;

  let fluxQuery = `join(tables: {bpm: ${t1}, timestamp: ${t2}}, on: ["_time"])`;

  showInfo(req);
  let myPromise = new Promise(function (myResolve, myReject) {
    data.length = 0; // clear array
    queryApi.queryRows(fluxQuery, {
      next(row, tableMeta) {
        const o = tableMeta.toObject(row);
        data.push(o);
      },
      error(error) {
        console.error(error);
        console.log("\nFinished ERROR");
        myReject("Error");
      },
      complete() {
        console.log("\nFinished gettingData SUCCESS");
        myResolve(data);
      },
    });
  });

  myPromise.then(
    function (value) {
      res.send(value); // determine content-type automatically
    },
    function (error) {
      console.log(error);
    }
  );
});

// Medium list of data
app.get("/bpm/medium", (req, res) => {
  // Query for 1 minute of data
  let t1 =
  `from(bucket: "${bucket}") |> range(start: -${mediumQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldBpmName}")`;
  let t2 =
  `from(bucket: "${bucket}") |> range(start: -${mediumQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldTimestampName}")`;

  let fluxQuery = `join(tables: {bpm: ${t1}, timestamp: ${t2}}, on: ["_time"])`;

  showInfo(req);
  let myPromise = new Promise(function (myResolve, myReject) {
    data.length = 0; // clear array
    queryApi.queryRows(fluxQuery, {
      next(row, tableMeta) {
        const o = tableMeta.toObject(row);
        data.push(o);
      },
      error(error) {
        console.error(error);
        console.log("\nFinished ERROR");
        myReject("Error");
      },
      complete() {
        console.log("\nFinished gettingData SUCCESS");
        myResolve(data);
      },
    });
  });

  myPromise.then(
    function (value) {
      res.send(value); // determine content-type automatically
    },
    function (error) {
      console.log(error);
    }
  );
});

// Long list of data
app.get("/bpm/long", (req, res) => {
  // Query for 2 minutes of data
  let t1 =
  `from(bucket: "${bucket}") |> range(start: -${longQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldBpmName}")`;
  let t2 =
  `from(bucket: "${bucket}") |> range(start: -${longQuery}) |> filter(fn: (r) => r._measurement == "${measurementName}" and r._field == "${fieldTimestampName}")`;

  let fluxQuery = `join(tables: {bpm: ${t1}, timestamp: ${t2}}, on: ["_time"])`;

  showInfo(req);
  let myPromise = new Promise(function (myResolve, myReject) {
    data.length = 0; // clear array
    queryApi.queryRows(fluxQuery, {
      next(row, tableMeta) {
        const o = tableMeta.toObject(row);
        data.push(o);
      },
      error(error) {
        console.error(error);
        console.log("\nFinished ERROR");
        myReject("Error");
      },
      complete() {
        console.log("\nFinished gettingData SUCCESS");
        myResolve(data);
      },
    });
  });

  myPromise.then(
    function (value) {
      res.send(value); // determine content-type automatically
    },
    function (error) {
      console.log(error);
    }
  );
});

app.listen(3000, (err) => {
  if (err) {
    console.log("There was an error", err);
    return;
  }
  console.log("Server running on http://127.0.0.1:3000"); // change to 192.168.0.188:3000 for RPI
});
