import { APIGatewayProxyEvent, APIGatewayProxyEventV2, APIGatewayProxyResult, APIGatewayProxyResultV2 } from 'aws-lambda';
import { getEngravers } from './get-engraver';
import { getEngraverById } from './get-engraver-by-id';
import { formatResponse } from './utils';

export const handler = async (
  event: APIGatewayProxyEventV2
): Promise<APIGatewayProxyResultV2> => {
  try {
    const method = event.requestContext.http.method;
    const pathParameters = event.pathParameters;

    console.log('Event received:', event);

    // Only handle GET requests
    console.log({
      pathParameters,
      method
    });

    // Only handle GET requests
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