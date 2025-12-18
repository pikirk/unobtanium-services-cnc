import { Engraver, PaginationParams, PaginatedEngravers, HandlerResult } from './types';

// Mock data - replace with actual database calls
const mockEngravers: Engraver[] = [
  { id: '1', name: 'John Smith', location: 'Seattle, WA', specialty: 'Wood', active: true },
  { id: '2', name: 'Jane Doe', location: 'Portland, OR', specialty: 'Metal', active: true },
  { id: '3', name: 'Bob Wilson', location: 'San Francisco, CA', specialty: 'Glass', active: true },
  { id: '4', name: 'Alice Brown', location: 'Denver, CO', specialty: 'Stone', active: false },
  { id: '5', name: 'Charlie Davis', location: 'Austin, TX', specialty: 'Wood', active: true },
];

export const getEngravers = async (
  queryParams: PaginationParams
): Promise<HandlerResult<PaginatedEngravers>> => {
  try {
    // Parse pagination parameters with defaults
    const page = parseInt(queryParams.p || '1', 10);
    const pageSize = parseInt(queryParams.s || '10', 10);

    // Validate pagination params
    if (page < 1 || pageSize < 1 || pageSize > 100) {
      return {
        data: {
          error: 'Invalid pagination parameters. Page must be >= 1, size must be 1-100'
        } as any,
        statusCode: 400
      };
    }

    // Calculate pagination
    const startIndex = (page - 1) * pageSize;
    const endIndex = startIndex + pageSize;

    // Get paginated results
    const paginatedEngravers = mockEngravers.slice(startIndex, endIndex);

    const result: PaginatedEngravers = {
      engravers: paginatedEngravers,
      page,
      pageSize,
      totalCount: mockEngravers.length
    };

    return {
      data: result,
      statusCode: 200
    };

  } catch (error) {
    console.error('Error fetching engravers:', error);
    return {
      data: { error: 'Failed to fetch engravers' } as any,
      statusCode: 500
    };
  }
};