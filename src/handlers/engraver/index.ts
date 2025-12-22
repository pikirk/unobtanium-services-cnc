import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { getEngravers } from './get-engraver';
import { getEngraverById } from './get-engraver-by-id';
import { formatResponse } from './utils';

export const handler = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  try {
    const method = event.httpMethod;
    const pathParameters = event.pathParameters;

    // Only handle GET requests
    console.log("pathParameters:", pathParameters);
    console.log("method:", method);
    if (method !== 'GET') {
      return formatResponse(
        { error: 'Method/Verb not allowed' },
        405
      );
    }

    // GET /engraver/{id}
    if (pathParameters?.id) {
      const result = await getEngraverById(pathParameters.id);
      return formatResponse(result.data, result.statusCode);
    }

    // GET /engraver (with optional pagination)
    const queryParams = event.queryStringParameters || {};
    const result = await getEngravers(queryParams);
    return formatResponse(result.data, result.statusCode);

  } catch (error) {
    console.error('Handler error:', error);
    return formatResponse(
      { error: 'Internal server error' },
      500
    );
  }
};