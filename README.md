# IT Service Graph Demo Explanation

The Demo is using Neo4j and NeoDash building an IT Service Graph UI.

The Demo is aimed to show a Knowledge Graph consisting of IT Infrastructure Data as well as IT Services and Customer Information. 

The strength of a Graph Database is, to combine those data sources and provide more detailed and valuable insights, 
that e.g. a CMDB alone cannot provide. The following Dashboard pages are available:

- **Demo Explanation** ==> Contains this information and two graphics of the data model, one without properties, one with properties.
- **IT Services Graph Overview** ==> Provides an Overview about Items in the Graph DB.
- **WAN Connection Overview** ==> Overview of the WAN Network with details on the connections and providers.
- **Service Impact Analysis** ==> Enables the user to analyse a server, service and software failure and simulate related issues for customer
- **Reverse Service Down Impact Analysis** ==> Lets the users analyze, what cost and users are affected from a services downtime.
- **Reverse Software Issue Analysis** ==> Similar to the latter Impact analysis, but from a software related issue 
- **Reverse Affected Customer Analysis** ==> And a third one, that can be used to analyze downtime issues of services for a specific customers


**NOTE:** All server, customer and software data in the graph was syntetically generated, thus names, version, etc. do not exist in the real world and are only used for demo purpose.

In order to install the demo locally do the following:

1. Create an empty Neo4j database. Use for example [Neo4j Aura](https://console.neo4j.io/), an empty [Neo4j Sandbox](https://sandbox.neo4j.com/) or Neo4j Desktop.
2. When the database is  up and running, open Neo4j Browser and run first the commands provided in the script ``ìndexes.cypher````
3. Next load the data and run the commands provided in the script ```load_all_it-service-data.cypher````
4. Once indexes/contraints are created, go to [NeoDash](https://neodash.graphapp.io/) if you are using AuraDB or a Sandbox and choose New Dashboard. Click "Yes" on the next dialog. In case you use Neo4j Desktop, make sure you installed NeoDash via the AppsGallery before you contiue.  
5. In the following dialog, enter the hostname (copy that from your AuraDB or Sandbox environments, if you use Neo4j Desktop run NeoDash locally and also choose "New Dashboard". But enter ```localhost``` as the connection string. Then click the ```Connect``` button (all types of Neo4j)
6. Once connected, click the ```+```icon in the upper right corner and choose ```Import```. In the window that opens, cut and paste the JSON content of the JSON file ```itgraph_dashboard_<last date saved>.json``` and paste it into the window. Scroll down and click the ```Import``` button to finally import the file. 
7. Then save it into your database by clicking the 3 dots on the left next to the braun rectangle with the name of the dashboard in it. It will become blue, once you confirm saving.
8. Enjoy the demo!  
