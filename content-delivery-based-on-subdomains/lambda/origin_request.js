'use strict';

exports.handler = async (event, context, callback) => {
    const request = event.Records[0].cf.request;

    console.log("Event: " + JSON.stringify(event));

    const subDomain = request.headers.host[0].value.split(".")[0];
    const s3BucketRegionalDomainName = request.origin.s3.customHeaders["x-env-s3-bucket-regional-domain-name"][0].value
    
    request.headers['host'] = [{ key: 'host', value: s3BucketRegionalDomainName}];
    
    request.uri = "/" + subDomain + "/index.html";

    console.log("Request: " + JSON.stringify(request));
      
    try {
        callback(null, request);
    } catch (error) {
        console.error("Error processing request:", error);
        callback(error);
    }
};
