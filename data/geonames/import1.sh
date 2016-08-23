export JDBC_IMPORTER_HOME=/tmp/elasticsearch-jdbc-2.3.3.1
export bin=$JDBC_IMPORTER_HOME/bin
export lib=$JDBC_IMPORTER_HOME/lib

echo '{
    "type" : "jdbc",
    "jdbc" : {
        "driver" : "org.xbib.jdbc.csv.CsvDriver",
        "url" : "jdbc:xbib:csv:/Users/markvarley/git/elasticsearch-geo/data/geonames?separator=\t&quotechar=|",
        "index" : "cities15000",
        "type" : "city",
        "sql" : "select * from cities15000"
    }
}' | java \
       -cp "${lib}/*" \
       -Dlog4j.configurationFile=${bin}/log4j2.xml \
       org.xbib.tools.Runner \
       org.xbib.tools.JDBCImporter
