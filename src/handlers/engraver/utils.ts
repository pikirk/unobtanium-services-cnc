import { APIGatewayProxyResult } from 'aws-lambda';
import { ApiResponse } from './types';

export const formatResponse = (
  data: any,
  statusCode: number = 200
): APIGatewayProxyResult => {
  const response: ApiResponse = {
    result: data,
    resultCode: statusCode
  };

  return {
    statusCode,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*', // Configure as needed
    },
    body: JSON.stringify(response, null, 2) // Pretty formatting
  };
};