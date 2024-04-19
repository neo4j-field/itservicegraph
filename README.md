# IT Service Graph Demo Explanation

The Demo is using Neo4j and NeoDash building an IT Service Graph UI.

The Demo is aimed to show a Knowledge Graph consisting of IT Infrastructure Data as well as IT Services and Customer Information. 

The strength of a Graph Database is, to combine those data sources and provide more detailed and valuable insights, 
that e.g. a CMDB alone cannot provide. The following Dashboard pages are available:

**Demo Explanation** ==> Contains this information and two graphics of the data model, one without properties, one with properties.
**IT Services Graph Overview** ==> Provides an Overview about Items in the Graph DB.
**Service Impact Analysis** ==> Enables the user to analyse a server, service and software failure and simulate related issues for customer
**Reverse Service Down Impact Analysis** ==> Lets the users analyze, what cost and users are affected from a services downtime.
**Reverse Software Issue Analysis** ==> Similar to the latter Impact analysis, but from a software related issue 
**Reverse Affected Customer Analysis** ==> And a third one, that can be used to analyze downtime issues of services for a specific customers
**WAN Connection Overview** ==> Overview of the WAN Network with details on the connections and providers.

**NOTE:** All server, customer and software data in the graph was generated, thus names, version, etc. do not exist in the real world and only used for demo purpose.
