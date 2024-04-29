// Indexes and Unique Constraints
// To run the following in Neo4j Workspace (AuraDB), remove the remarks and run only the Cypher statements!
CREATE CONSTRAINT networkComponentUnique FOR (n:NetworkComponent) REQUIRE (n.assetNr) IS UNIQUE;
CREATE CONSTRAINT serverAssetUnique FOR (n:Server) REQUIRE (n.assetNr) IS UNIQUE;

CREATE CONSTRAINT subNetIPExists FOR (n:SubNet) REQUIRE n.subnetIP IS NOT NULL;
CREATE CONSTRAINT subNetMaskExists FOR (n:SubNet) REQUIRE n.subnetMask IS NOT NULL;
CREATE CONSTRAINT customerNameExists FOR (n:Customer) REQUIRE n.customerName IS NOT NULL;
CREATE CONSTRAINT serviceOwnerExists FOR (n:Service) REQUIRE n.serviceOwner IS NOT NULL;
CREATE CONSTRAINT serviceNameExists FOR (n:Service) REQUIRE n.serviceName IS NOT NULL;

CREATE CONSTRAINT dcSecNameExists FOR (n:Section) REQUIRE n.dcSecName IS NOT NULL;
CREATE CONSTRAINT swNameExists FOR (n:Software) REQUIRE n.swName IS NOT NULL;

CREATE CONSTRAINT leaseEndExists FOR (n:NetworkComponent) REQUIRE n.leaseEnd IS NOT NULL;
CREATE CONSTRAINT installDateExists FOR (n:NetworkComponent) REQUIRE n.installDate IS NOT NULL;
CREATE CONSTRAINT assetNrExistsNet FOR (n:NetworkComponent) REQUIRE n.assetNr IS NOT NULL;
CREATE CONSTRAINT serverNameExists FOR (n:Server) REQUIRE n.serverName IS NOT NULL;
CREATE CONSTRAINT assetNrExistsSvr FOR (n:Server) REQUIRE n.assetNr IS NOT NULL;

// Indexes
CREATE INDEX IF NOT EXISTS FOR (n:Customer) ON (n.customerName);
CREATE INDEX IF NOT EXISTS FOR (n:Service) ON (n.serviceOwner);
CREATE INDEX IF NOT EXISTS FOR (n:Service) ON (n.serviceName);
CREATE INDEX IF NOT EXISTS FOR (n:Software) ON (n.swFirstSeen);
CREATE INDEX IF NOT EXISTS FOR (n:Software) ON (n.swLastUpdate);
CREATE INDEX IF NOT EXISTS FOR (n:Software) ON (n.swName);
CREATE INDEX IF NOT EXISTS FOR (n:NetworkComponent) ON (n.modelName);
CREATE INDEX IF NOT EXISTS FOR (n:Server) ON (n.serverName);
