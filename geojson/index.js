// Import the official elastiscearch library
var elasticsearch = require('elasticsearch');

// Setup the client
var client = new elasticsearch.Client({
  host: 'localhost:9200'
});

// Execute the search
client.search({
  index: 'cities',
  type: 'city',
  body: {
    // Only pull through the fields we need
    _source: { include: ['name','location'] },
    // Match eveything within 25km of the WCCB, Bonn
    query: {
      bool: {
        must: {
          match_all: {}
        },
        filter: {
          geo_distance: {
            distance: '25km',
            location: {
              lat: 50.719151,
              lon: 7.124129
            }
          }
        }
      }
    }
  }
}).then(function (resp) {

  // Setup an empty FeatureCollection object
  var FeatureCollection = { type: 'FeatureCollection', features: [] }

  // Convert the hits to GeoJson
  FeatureCollection.features = resp.hits.hits.map(function(hit) {
    return {
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: [hit._source.location.lon, hit._source.location.lat]
      },
      properties: {
        name: hit._source.name
      }
    }
  })

  // Pretty print the results to the console
  // Note: these could be displayed on a map, test the results at http://geojsonlint.com/
  console.log(JSON.stringify(FeatureCollection, null, 2));

}, function (err) {
  console.trace(err.message);
});
