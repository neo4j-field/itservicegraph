
// Load generated IT Service Graph Demo Data
// To run the following in Neo4j Workspace (AuraDB), remove the remarks and run only the Cypher statements!

:param filename => 'https://raw.githubusercontent.com/neo4j-field/itservicegraph/main/data/rz.csv';

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ','
WITH line.dcname AS dcName, line.dccity as dcCity, line.dclat AS dcLat, line.dclong AS dcLong 
MERGE (a:Datacenter {dcName: dcName})
ON CREATE SET a.dcName = dcName,
a.dcCity = dcCity,
a.dcLat = dcLat,
a.dcLocLat = dcLong,
a.dcGeoLoc = point({latitude: toFLoat(dcLat), longitude: toFLoat(dcLong)})
RETURN count(*);

:param filename => 'https://raw.githubusercontent.com/neo4j-field/itservicegraph/main/data/server.csv';

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ','
WITH line.servername AS serverName, line.manufacturer AS manufacturer, line.model AS model, line.assetNr AS assetNr, line.installDate AS installDate, line.serverLeaseEnd AS leaseEnd
MERGE (a:Server {serverName: serverName})
ON CREATE SET a.manufacturer = manufacturer,
a.model = model,
a.assetNr = assetNr,
a.installDate = date(installDate),
a.serverLeaseEnd = date(leaseEnd)
RETURN count(*); 

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ','
WITH line.servername AS serverName, line.cluster AS cluster, line.datacenter AS dcName
MERGE (a:Cluster {clusterName: cluster})
WITH cluster, serverName, dcName
MATCH (a:Server {serverName: serverName})
MATCH (d:Datacenter {dcName: dcName})
MATCH (c:Cluster {clusterName: cluster})
MERGE (a)-[:LOCATED_IN]->(d)
MERGE (a)-[:BELONGS_TO]->(c)
RETURN count(*);


// Load infra data

:param filename => 'https://raw.githubusercontent.com/neo4j-field/itservicegraph/main/data/rz-sections-server.csv';

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ';'
WITH line.datacenter AS dcName, line.dcSecName AS dcSecName, line.rackAmountUnits AS rackAmountUnits, line.rackAmountFreeUnits AS rackAmountFreeUnits, line.rackManufacturer AS rackManufacturer, line.rackName AS rackName, line.rackRZRow AS rackRZRow
MATCH (d:Datacenter {dcName: dcName})
MERGE (s:Section {dcSecName: dcSecName})
ON CREATE SET s.dcSecGeo = d.dcGeoLoc
MERGE (a:Rack {rackName: rackName})
ON CREATE SET a.rackAmountUnits = rackAmountUnits,
a.rackAmountFreeUnits = rackAmountFreeUnits,
a.rackManufacturer = rackManufacturer
WITH rackName, dcName, dcSecName
MATCH (a:Rack {rackName: rackName})
MATCH (d:Datacenter {dcName: dcName})
MATCH (s:Section {dcSecName: dcSecName})
MERGE (d)-[:IN_SECTION]->(s)
MERGE (s)-[:IN_RACK]->(a)
RETURN count(*);


// load software, services and customer

:param filename => 'https://raw.githubusercontent.com/neo4j-field/itservicegraph/main/data/server-app-service-customer.csv';

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ';'
WITH line.appOwner AS swOwner, line.appName AS swName, line.appVersion AS swVersion
MERGE (a:Software {swName: swName})
ON CREATE SET a.swVersion = swVersion,
a.swVendor = "Vendor-"+swName,
a.swFirstSeen = date() - duration('P1Y'),
a.swLastUpdated = date() - duration('P2Y'),
a.swOwner = swOwner
RETURN count(*);

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ';'
WITH line.serviceName AS serviceName, line.serviceOwner AS serviceOwner, line.serviceSLA AS serviceSLA
MERGE (a:Service {serviceName: serviceName})
ON CREATE SET a.serviceOwner = serviceOwner,
a.outageCostperHour = toFloat(1536.27 * toFloat(serviceSLA)),
a.serviceSLA = "level-" + serviceSLA
RETURN count(*);

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ';'
WITH line.customerName AS customerName, line.customerDept AS customerDept, line.customerImportance AS customerImportance, line.customerOnBoardDate AS onboardingDate
MERGE (a:Customer {customerName: customerName})
ON CREATE SET a.customerDept = customerDept,
a.customerImportance = customerImportance,
a.onboardingDate = date(datetime({epochmillis: apoc.date.parse(onboardingDate, "ms", "dd/MM/yyyy")}))
RETURN count(*);

:param filename => 'https://raw.githubusercontent.com/neo4j-field/itservicegraph/main/data/server-app-service-customer.csv';
LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ';'
WITH line.servername AS serverName, line.serviceName AS serviceName, line.customerName AS customerName, line.appName AS swName, line.customerOnBoardDate AS onboardingDate
MATCH (s:Server {serverName: serverName})
MATCH (sw:Software {swName: swName})
MERGE (sw)-[:RUNS_ON]->(s)
RETURN count(*);

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ';'
WITH line.servername AS serverName, line.serviceName AS serviceName, line.customerName AS customerName, line.appName AS swName, line.customerOnBoardDate AS onboardingDate
MATCH (sr:Server {serverName: serverName})
MATCH (sw:Software {swName: swName})
MATCH (sv:Service {serviceName: serviceName})
MERGE (sw)-[:DELIVERS]->(sv)
MERGE (sr)-[d:RUNS]->(sv)
ON CREATE SET d.serviceSLA = sv.serviceSLA
RETURN count(*);

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ';'
WITH line.servername AS serverName, line.serviceName AS serviceName, line.customerName AS customerName, line.appName AS swName, line.customerOnBoardDate AS onboardingDate, line.customerImportance AS customerImportance
MATCH (sv:Service {serviceName: serviceName})
MATCH (c:Customer {customerName: customerName})
MERGE (sv)-[cb:CONSUMED_BY]->(c)
ON CREATE SET cb.customerOnboardDate = date(datetime({epochmillis: apoc.date.parse(onboardingDate, "ms", "dd/MM/yyyy")})),
cb.customerImportance = customerImportance
RETURN count(*);


// load additonal hardware/software data

:param filename => 'https://raw.githubusercontent.com/neo4j-field/itservicegraph/main/data/clusters.csv';

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ';'
WITH line.cluster AS clusterName, line.clusterVersion AS clusterVersion, line.clusterSW AS clusterSW, line.clusterLastUpdate AS clusterLastUpdate
MATCH (a:Cluster {clusterName: clusterName})
SET a.clusterVersion = clusterVersion,
a.clusterSW = clusterSW,
a.clusterLastUpdate = clusterLastUpdate
RETURN count(*);

// load dc to dc data

:param filename => 'https://raw.githubusercontent.com/neo4j-field/itservicegraph/main/data/dc2dc.csv';

LOAD CSV WITH HEADERS FROM $filename AS line FIELDTERMINATOR ';'
WITH line.dc1 AS dc1, line.dc2 AS dc2, line.provider AS provider, line.thruput AS thruput, line.distance AS distance, line.roundtrip AS roundtrip
MATCH(d1:Datacenter {dcName: dc1})
MATCH(d2:Datacenter {dcName: dc2})
CREATE (d1)-[r:HAS_WAN_CONNECTION]->(d2)
SET r.provider = provider,
r.thruput = toFloat(thruput),
r.distance = toFloat(distance),
r.avgRoundTripMS = toInteger(roundtrip)
RETURN count(*);
