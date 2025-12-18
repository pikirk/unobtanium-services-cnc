import { Engraver, HandlerResult } from './types';

// Mock data - replace with actual database calls
const mockEngravers: Engraver[] = [
  { id: '1', name: 'John Smith', location: 'Seattle, WA', specialty: 'Wood', active: true },
  { id: '2', name: 'Jane Doe', location: 'Portland, OR', specialty: 'Metal', active: true },
  { id: '3', name: 'Bob Wilson', location: 'San Francisco, CA', specialty: 'Glass', active: true },
  { id: '4', name: 'Alice Brown', location: 'Denver, CO', specialty: 'Stone', active: false },
  { id: '5', name: 'Charlie Davis', location: 'Austin, TX', specialty: 'Wood', active: true },
];

export const getEngraverById = async (
  id: string
): Promise<HandlerResult<Engraver | { error: string }>> => {
  try {
    // Validate ID
    if (!id || id.trim() === '') {
      return {
        data: { error: 'Invalid engraver ID' },
        statusCode: 400
      };
    }

    // Find engraver by ID
    const engraver = mockEngravers.find(e => e.id === id);

    if (!engraver) {
      return {
        data: { error: `Engraver with ID ${id} not found` },
        statusCode: 404
      };
    }

    return {
      data: engraver,
      statusCode: 200
    };

  } catch (error) {
    console.error('Error fetching engraver by ID:', error);
    return {
      data: { error: 'Failed to fetch engraver' },
      statusCode: 500
    };
  }
};