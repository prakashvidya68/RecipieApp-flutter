const functions = require('firebase-functions');
const admin = require('firebase-admin');
const _ = require('lodash');
const request = require('request-promise');




admin.initializeApp(functions.config().firebase);

exports.indexMealstoElasticsearch = functions.firestore
    .document('meals/{mealId}')
    .onWrite(async (change, context) => {
        let mealData = change.after.data();
        let id = context.params.mealId;

        console.log('Indexing meal ', id, mealData);

        let elasticSearchConfig = functions.config().elasticsearch;
        let elasticSearchUrl = elasticSearchConfig.url + 'meals/_doc/'+id;
        let elasticSearchMethod = mealData ? 'POST' : 'DELETE';

        let elasticsearchRequest = {
            method: elasticSearchMethod,
            url: elasticSearchUrl,
            auth: {
                username: elasticSearchConfig.username,
                password: elasticSearchConfig.password,
            },
            body: mealData,
            json: true
        };

        // eslint-disable-next-line promise/always-return
        return request(elasticsearchRequest).then(response => {
            console.log('Elasticsearch response', response);
        });
    });