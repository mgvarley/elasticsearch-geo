export JDBC_IMPORTER_HOME=/tmp/elasticsearch-jdbc-2.3.3.1
export bin=$JDBC_IMPORTER_HOME/bin
export lib=$JDBC_IMPORTER_HOME/lib

echo '{
    "type" : "jdbc",
    "jdbc" : {
        "driver" : "org.xbib.jdbc.csv.CsvDriver",
        "url" : "jdbc:xbib:csv:/Users/markvarley/git/elasticsearch-geo/data/geonames?separator=\t&quotechar=|&columnTypes=String,String,String,String,Double,Double,String,String,String,String,String,String,String,String,Int,Int,String,String,String",
        "index" : "cities15000",
        "type" : "city",
        "sql" : "select geonameid as _id, name, asciiname, alternatenames, latitude as \"location.lat\", longitude as \"location.lon\", feature_class, feature_code, country_code, cc2, admin1_code, admin2_code, admin3_code, admin4_code, population, elevation, dem, timezone, modification_date from cities15000",
        "ignore_null_values": true
    }
}' | java \
       -cp "${lib}/*" \
       -Dlog4j.configurationFile=${bin}/log4j2.xml \
       org.xbib.tools.Runner \
       org.xbib.tools.JDBCImporter