// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
import ballerina/log;
import ballerinax/salesforce;

public function main() returns error? {

    // Create Salesforce client configuration by reading from config file.
    salesforce:ConnectionConfig sfConfig = {
        baseUrl: "<BASE_URL>",
        clientConfig: {
            clientId: "<CLIENT_ID>",
            clientSecret: "<CLIENT_SECRET>",
            refreshToken: "<REFESH_TOKEN>",
            refreshUrl: "<REFRESH_URL>"
        }
    };

    // Create Salesforce client.
    salesforce:Client baseClient = check new (sfConfig);

    string accountId = "0015Y00002adeBWQAY";

    record{}|error res = baseClient->getById("Account", accountId, ["Name", "BillingCity"]);

    if res is record{} {
        anydata recName = res["Name"];
        log:printInfo("Record data received successfully. Record Name : " + recName.toString());
        
    } else {
        log:printError(msg = res.message());
    }
}
