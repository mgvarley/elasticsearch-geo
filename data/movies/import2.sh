export JDBC_IMPORTER_HOME=/tmp/elasticsearch-jdbc-2.3.3.1
export bin=$JDBC_IMPORTER_HOME/bin
export lib=$JDBC_IMPORTER_HOME/lib

echo '{
    "type" : "jdbc",
    "jdbc" : {
        "driver" : "org.xbib.jdbc.csv.CsvDriver",
        "url" : "jdbc:xbib:csv:/Users/markvarley/git/elasticsearch-geo/data/movies?columnTypes=Int,String,Int,Int,Int,Double,Int,Double,Double,Double,Double,Double,Double,Double,Double,Double,Double,String,Boolean,Boolean,Boolean,Boolean,Boolean,Boolean,Boolean",
        "index" : "imdb",
        "type" : "movie",
        "sql" : "select title, year, budget, length, rating, votes, mpaa, action, animation, comedy, drama, documentary, romance, short from movies"
    }
}' | java \
       -cp "${lib}/*" \
       -Dlog4j.configurationFile=${bin}/log4j2.xml \
       org.xbib.tools.Runner \
       org.xbib.tools.JDBCImporter