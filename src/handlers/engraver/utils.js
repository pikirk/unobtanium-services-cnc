"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.formatResponse = void 0;
var formatResponse = function (data, statusCode) {
    if (statusCode === void 0) { statusCode = 200; }
    var response = {
        result: data,
        resultCode: statusCode
    };
    return {
        statusCode: statusCode,
        headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*', // Configure as needed
        },
        body: JSON.stringify(response, null, 2) // Pretty formatting
    };
};
exports.formatResponse = formatResponse;
